extends CanvasLayer

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CoinCount.text = str(score)
	$CoinSprite.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func coin_collected(coin):
	score = coin
	$CoinCount.text = str(score)
