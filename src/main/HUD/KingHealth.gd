extends Label

@onready var king = get_node("../../GameBoard/PlayerPieces/King")

func _process(_delta):
	text = String.num(king.health)
