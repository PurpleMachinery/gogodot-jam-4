extends CharacterBody2D
class_name Pawn

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var rayCastLeft: RayCast2D = $RayCast2DLeft
@onready var rayCastRight: RayCast2D = $RayCast2DRight

@export var startSpace: Node2D
@export var damage: int = 1

var attackTimer: Timer = Timer.new()

var dragging: bool = false
var rest_point: Vector2

@export var canBeMoved: bool = false


func _ready():
	if(startSpace is Marker2D):
		rest_point = startSpace.global_position
		startSpace.select(self)
	elif(startSpace is Node2D):
		rest_point = startSpace.get_node("FixPoint").global_position
		startSpace.get_node("FixPoint").select(self)

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
	
	if(!dragging && attackTimer.is_stopped() && firstEnemy != null):
		if(enemyLeft):
			animationPlayer.play("attack_left")
		else:
			animationPlayer.play("attack_right")

		firstEnemy.get_owner().dealDamage(damage)
		sprite.modulate = Color(1, 0, 0, 1)
		attackTimer.start(4)


func _physics_process(delta):
	if dragging:
		var mousepos = get_global_mouse_position()
		global_position = lerp(global_position, mousepos, 20 * delta)
	else:
		global_position = lerp(global_position, rest_point, 5 * delta)


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if (canBeMoved && event is InputEventMouseButton):
		if (event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
			dragging = true
		if (event.button_index == MOUSE_BUTTON_LEFT and !event.pressed):
			dragging = false
			var shortest_dist = 6
			for child in get_tree().get_nodes_in_group("zone"):
				var distance = global_position.distance_to(child.global_position)
				if(child.canBeUsed && distance < shortest_dist):
					canBeMoved = false
					child.select(self)
					rest_point = child.global_position
