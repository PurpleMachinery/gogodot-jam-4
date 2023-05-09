extends Node2D
class_name EnemyPawn

@onready var pathToFollow: Curve2D = get_node("../../EnemyPath/Path2D").get_curve()
@onready var king = get_node("../../PlayerPieces/King")

@onready var nextPoint: int = 0
@onready var nextPosition: Vector2 = pathToFollow.get_point_position(nextPoint)

@export_group("Pawn Status")
@export var health: int = 1
@export var damage: int = 1
@export var delayStartMove: int = 3

var localTimer: Timer = Timer.new()

var hasToDie: bool = false


func _ready():
	localTimer.one_shot = true
	add_child(localTimer)
	localTimer.start(delayStartMove)


func _process(_delta):
	if(round(position) == nextPosition):
		if(hasToDie):
			queue_free()
		if(localTimer.is_stopped()):
			readNextPoint()
	else:
		var tween: Tween = create_tween()
		tween.tween_property(self, "position", nextPosition, 0.4)
		await tween.finished
		tween.kill()


func readNextPoint():
	nextPoint = nextPoint + 1;

	if(pathToFollow.point_count == nextPoint):
		king.dealDamage(damage);
		queue_free()
		return

	nextPosition = pathToFollow.get_point_position(nextPoint)
	localTimer.start(1)


func dealDamage(damageReceived):
	health -= damageReceived

	if(health <= 0):
		hasToDie = true
