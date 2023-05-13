extends Node2D
class_name LessIsMore


@onready var enemyPieces: EnemyPieces = get_node("GameBoard/EnemyPieces")

@export var playerCoins: int = 3

var canCallNextWave: bool


func _process(_delta):
	canCallNextWave = enemyPieces.get_child_count() == 0


func runNextRound():
	enemyPieces.runNextRound()


func canBuyPiece(price) -> bool:
	return playerCoins - price >= 0


func buyPiece(price: int) -> void:
	playerCoins -= price