extends CharacterBody2D
class_name Pawn

@onready var root: LessIsMore = get_tree().get_current_scene()
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var rayCastLeft: RayCast2D = $RayCast2DLeft
@onready var rayCastRight: RayCast2D = $RayCast2DRight
@onready var panel: Panel = $Panel
@onready var textLabel: Label = $Panel/Label

@export var canBeMoved: bool = false
@export var startSpace: Node2D

var attackTimer: Timer = Timer.new()
var damage: int = 1
var price: int = 3
var attackDelay: float = 4

var dragging: bool = false
var rest_point: Vector2


func _ready():
	if(startSpace is Marker2D):
		rest_point = startSpace.global_position
		startSpace.select(self)
	elif(startSpace is Node2D):
		rest_point = startSpace.get_node("FixPoint").global_position
		startSpace.get_node("FixPoint").select(self)
	
	textLabel.text = "Damage: ${1}\nDelay: ${2} sec".replace("${1}", str(damage)).replace("${2}", str(attackDelay))

	attackTimer.one_shot = true
	add_child(attackTimer)


func _physics_process(delta):
	var correctColor = lerp(sprite.modulate.g, 1.0, 0.0065)
	sprite.modulate = Color(1, correctColor, correctColor, 1)

	rayCastLeft.visible = dragging
	rayCastRight.visible = dragging

	var enemyLeft: bool = true
	var firstEnemy = rayCastLeft.get_collider()

	if(firstEnemy == null):
		enemyLeft = false
		firstEnemy = rayCastRight.get_collider()
	
	if(!dragging && !canBeMoved && attackTimer.is_stopped() && firstEnemy != null && !firstEnemy.get_owner().hasToDie):
		if(enemyLeft):
			animationPlayer.play("attack_left")
		else:
			animationPlayer.play("attack_right")

		firstEnemy.get_owner().dealDamage(damage)
		sprite.modulate = Color(1, 0, 0, 1)
		attackTimer.start(attackDelay)
	if dragging:
		var mousepos = get_global_mouse_position()
		global_position = lerp(global_position, mousepos, 20 * delta)
	else:
		global_position = lerp(global_position, rest_point, 5 * delta)


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if (root.canBuyPiece(price) && canBeMoved && event is InputEventMouseButton):
		if (event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
			_on_mouse_exited()
			dragging = true
		if (event.button_index == MOUSE_BUTTON_LEFT and !event.pressed):
			dragging = false
			var shortest_dist = 6
			for child in get_tree().get_nodes_in_group("zone"):
				var distance = global_position.distance_to(child.global_position)
				if(child.canBeUsed && distance < shortest_dist):
					root.buyPiece(price)
					#deixar nessa ordem funciona... não sei porque, não devia...
					fixatePosition(child)
					createSubstitute(self)
					#deixar nessa ordem funciona... não sei porque, não devia...


func fixatePosition(child: Marker2D):
	canBeMoved = false
	child.select(self)
	rest_point = child.global_position


func createSubstitute(oldPawn: Pawn):
	var newPawn = load("res://src/main/ChessPieces/Pawn.tscn").instantiate()

	newPawn.startSpace = oldPawn.startSpace
	newPawn.rest_point = oldPawn.rest_point
	newPawn.global_position = Vector2(200, -56)
	newPawn.canBeMoved = true

	oldPawn.get_parent().add_child(newPawn)


func _on_mouse_entered():
	panel.show()


func _on_mouse_exited():
	panel.hide()
