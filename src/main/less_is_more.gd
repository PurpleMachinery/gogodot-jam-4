extends Node2D
class_name LessIsMore

@export var playerCoins: int = 3

func _process(_delta):
	if(Input.is_action_just_pressed("ui_cancel")):
		get_tree().quit()


func canBuyPiece(price) -> bool:
	return playerCoins - price >= 0


func buyPiece(price: int) -> void:
	playerCoins -= price