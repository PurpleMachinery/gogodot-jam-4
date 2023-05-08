extends Node2D
class_name Pawn

@onready var rayCastLeft: RayCast2D = $RayCast2DLeft
@onready var rayCastRight: RayCast2D = $RayCast2DRight

@export var damage: int = 1

var attackTimer: Timer = Timer.new()

func _ready():
	attackTimer.one_shot = true
	add_child(attackTimer)


func _process(_delta):
	var firstEnemy = rayCastLeft.get_collider()

	if(firstEnemy == null):
		firstEnemy = rayCastRight.get_collider()
	
	if(attackTimer.is_stopped() && firstEnemy != null):
		firstEnemy.get_owner().dealDamage(damage)
		attackTimer.start(4)
