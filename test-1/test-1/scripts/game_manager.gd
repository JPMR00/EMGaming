extends Node

var score = 0
@onready var coin_counter: Node = $CoinCounter

func add_point():
	score += 1
	print(score)
	coin_counter.coin_collected(score)
