extends Node2D
class_name EnemyPieces


var enemyPawn = preload("res://src/main/ChessPieces/Enemies/EnemyPawn.tscn")

var currentRound = 5
var pawnsPerRound = [
	[newPawn([1, 1, 2, 1, 1]), newPawn([1, 1, 6, 1, 1])],
	[newPawn([1, 1, 2, 1, 1]), newPawn([1, 1, 3, 1, 1])],
	[newPawn([1, 1, 2, 1, 1]), newPawn([1, 1, 3, 1, 1]), newPawn([1, 1, 3.5, 1, 1]), newPawn([1, 1, 4, 1, 1])],
	[newPawn([1, 1, 2, 1, 1]), newPawn([1, 1, 3, 1, 1]), newPawn([1, 1, 3.5, 1, 1]), newPawn([1, 1, 4, 1, 1]), newPawn([1, 1, 3.5, 1, 1]), newPawn([1, 1, 4, 1, 1])],
	[newPawn([1, 1, 2, 1, 1]), newPawn([1, 1, 3, 1, 1]), newPawn([1, 1, 4, 1, 1]), newPawn([1, 1, 5, 1, 1]), newPawn([1, 1, 6, 1, 1]), newPawn([1, 1, 7, 1, 1]),
		newPawn([1, 1, 8, 1, 1]), newPawn([1, 1, 9, 1, 1])],
	
	[newPawn([1, 1, 2, 1, 1]), newPawn([1, 1, 3, 1, 1]), newPawn([1, 1, 4, 1, 1]), newPawn([1, 1, 5, 1, 1]), newPawn([1, 1, 6, 1, 1]), newPawn([1, 1, 7, 1, 1]),
		newPawn([1, 1, 8, 1, 1]), newPawn([1, 1, 9, 1, 1]), newPawn([1, 1, 10, 1, 1]), newPawn([1, 1, 11, 1, 1]), newPawn([1, 1, 12, 1, 1]), newPawn([1, 1, 13, 1, 1]),
		newPawn([1, 1, 14, 1, 1]), newPawn([1, 1, 15, 1, 1]), newPawn([1, 1, 16, 1, 1]), newPawn([1, 1, 17, 1, 1]), newPawn([1, 1, 18, 1, 1]), newPawn([1, 1, 19, 1, 1]),
		newPawn([1, 1, 20, 1, 1]), newPawn([1, 1, 21, 1, 1]), newPawn([1, 1, 22, 1, 1]), newPawn([1, 1, 23, 1, 1]), newPawn([1, 1, 24, 1, 1]), newPawn([1, 1, 25, 1, 1])],
	
	[newPawn([100, 20, 3, 1, 1])]
]


func runNextRound():
	for pawn in pawnsPerRound[min(currentRound, pawnsPerRound.size() - 1)]:
		add_child(pawn.duplicate())
	
	currentRound += 1


func newPawn(pawnData) -> EnemyPawn:
	var pawn: EnemyPawn = enemyPawn.instantiate()
	pawn.health = pawnData[0]
	pawn.damage = pawnData[1]
	pawn.delayStartMove = pawnData[2]
	pawn.stepDelay = pawnData[3]
	pawn.coinsReward = pawnData[4]
	
	if(pawn.health == 100):
		pawn.modulate = Color.RED
		pawn.scale = Vector2(1.3, 1.3)

	return pawn
