extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const stomp_impulse = 300.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Gets the direction based on the pressed action: -1, 0, 1
	var direction := Input.get_axis("Move_Left", "Move_Right")
	
	#Flip the Sprite based on direction moved
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	#Play Animations.
	if is_on_floor():
	#Change the animation state between idle or running, based on which action is being executed.
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")

	#Determine movement of the player character
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	#Determine number of times you colide with an object.
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var collider := collision.get_collider()
		print(str(collider))
		var is_stomping := (
			collider is Enemy and 
			is_on_floor() and
			collision.get_normal().is_equal_approx(Vector2.UP)
		)
		if is_stomping:
			velocity.y = -stomp_impulse
			print(str(collision.get_normal))
			(collider as Enemy).kill()

	#Base movement actions
	move_and_slide()
