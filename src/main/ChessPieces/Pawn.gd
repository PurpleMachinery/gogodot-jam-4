extends Node2D
class_name Pawn

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var rayCastLeft: RayCast2D = $RayCast2DLeft
@onready var rayCastRight: RayCast2D = $RayCast2DRight

@export var damage: int = 1

var tempCanPrint = false

var attackTimer: Timer = Timer.new()

func _ready():
	attackTimer.one_shot = true
	add_child(attackTimer)


func _process(_delta):
	var correctColor = lerp(sprite.modulate.g, 1.0, 0.0065)
	sprite.modulate = Color(1, correctColor, correctColor, 1)

	var enemyLeft: bool = true
	var firstEnemy = rayCastLeft.get_collider()

	if(firstEnemy == null):
		enemyLeft = false
		firstEnemy = rayCastRight.get_collider()
	
	if(attackTimer.is_stopped() && firstEnemy != null):
		if(enemyLeft):
			animationPlayer.play("attack_left")
		else:
			animationPlayer.play("attack_right")

		firstEnemy.get_owner().dealDamage(damage)
		sprite.modulate = Color(1, 0, 0, 1)
		attackTimer.start(4)
		tempCanPrint =true
