extends Node2D

@onready var pathToFollow: Curve2D = get_node("../../EnemyPath/Path2D").get_curve()
@onready var king = get_node("../../PlayerPieces/King")

@export var health: int = 1
@export var damage: int = 1

@onready var nextPoint: int = 18
@onready var nextPosition: Vector2 = pathToFollow.get_point_position(nextPoint)

var localTimer: Timer = Timer.new()


func _ready():
	localTimer.one_shot = true
	add_child(localTimer)


func _process(_delta):
	if(round(position) == nextPosition):
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
