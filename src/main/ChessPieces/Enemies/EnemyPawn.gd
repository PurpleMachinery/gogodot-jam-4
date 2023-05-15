extends Node2D
class_name EnemyPawn

@onready var root: LessIsMore = get_tree().get_current_scene()
@onready var pathToFollow: Curve2D = get_node("../../EnemyPath/Path2D").get_curve()
@onready var king = get_node("../../PlayerPieces/King")

@onready var nextPoint: int = 0
@onready var nextPosition: Vector2 = pathToFollow.get_point_position(nextPoint)

@export var health: int = 1
@export var damage: int = 1
@export var delayStartMove: float = 3
@export var coinsReward: int = 2
@export var stepDelay: float = 1

var localTimer: Timer = Timer.new()
var hasToDie: bool = false
var isLastBoss: bool = false


func _ready():
	position = pathToFollow.get_point_position(0)
	localTimer.one_shot = true
	add_child(localTimer)
	localTimer.start(delayStartMove)


func _process(_delta):
	if(round(position) == nextPosition):
		if(hasToDie):
			if(modulate == Color.RED):
				await get_tree().create_timer(2).timeout
				get_tree().change_scene_to_file("res://src/main/win.tscn")

			queue_free()
		if(localTimer.is_stopped()):
			readNextPoint()
	else:
		var tween: Tween = create_tween()
		tween.tween_property(self, "position", nextPosition, 0.4 * stepDelay)
		await tween.finished
		tween.kill()


func readNextPoint():
	nextPoint += 1;

	if(pathToFollow.point_count == nextPoint):
		king.dealDamage(damage);
		queue_free()
		return

	nextPosition = pathToFollow.get_point_position(nextPoint)
	localTimer.start(stepDelay)


func dealDamage(damageReceived):
	health -= damageReceived

	if(health <= 0):
		root.playerCoins += coinsReward
		hasToDie = true
		return


func turnBoss():
	modulate = Color.RED
	scale = Vector2(1.3, 1.3)
	return self