extends Node2D
class_name EnemyPieces


var enemyPawn = preload("res://src/main/ChessPieces/Enemies/EnemyPawn.tscn")

var currentRound = 0
var pawnsPerRound = [
	[[1, 1, 2, 1, 2], [1, 1, 3, 1, 2], [1, 1, 4, 1, 2], [1, 1, 5, 1, 2], [1, 1, 6, 1, 2], [1, 1, 7, 1, 2], [1, 1, 8, 1, 2], [1, 1, 9, 1, 2]]
]


func runNextRound():
	for pawnData in pawnsPerRound[min(currentRound, pawnsPerRound.size() - 1)]:
		var newPawn: EnemyPawn = enemyPawn.instantiate()
		newPawn.health = pawnData[0]
		newPawn.damage = pawnData[1]
		newPawn.delayStartMove = pawnData[2]
		newPawn.stepDelay = pawnData[3]
		newPawn.coinsReward = pawnData[4]

		add_child(newPawn)
	
	currentRound += 1
