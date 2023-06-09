extends CharacterBody2D
class_name Horse

@onready var root: LessIsMore = get_tree().get_current_scene()
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var panel: Panel = $Panel
@onready var textLabel: Label = $Panel/Label

var listRayCast: Array[RayCast2D] = []

@export var canBeMoved: bool = false
@export var startSpace: Node2D

var attackTimer: Timer = Timer.new()
var damage: int = 3
var price: int = 7
var attackDelay: float = 2.5

var dragging: bool = false
var rest_point: Vector2


func _ready():
	for child in get_children():
		if(child is RayCast2D):
			listRayCast.append(child)

	textLabel.text = "Damage: ${1}\nDelay: ${2} sec".replace("${1}", str(damage)).replace("${2}", str(attackDelay))

	if(startSpace is Marker2D):
		rest_point = startSpace.global_position
		startSpace.select(self)
	elif(startSpace is Node2D):
		rest_point = startSpace.get_node("FixPoint").global_position
		startSpace.get_node("FixPoint").select(self)

	attackTimer.one_shot = true
	add_child(attackTimer)


func _physics_process(delta):
	var correctColor = lerp(sprite.modulate.g, 1.0, 0.01)
	sprite.modulate = Color(1, correctColor, correctColor, 1)


	var firstEnemy
	for rayCast in listRayCast:
		rayCast.visible = dragging
		if(firstEnemy == null && rayCast.is_colliding()):
			firstEnemy = rayCast.get_collider()
	
	if(!dragging && !canBeMoved && attackTimer.is_stopped() && firstEnemy != null && !firstEnemy.get_owner().hasToDie):
		
		var anim: Animation = animationPlayer.get_animation("attack")
		var track_id: int = anim.find_track("Sprite2D:position", Animation.TYPE_VALUE)
		var key_id: int = anim.track_find_key(track_id, 0.2)
		anim.track_set_key_value(track_id, key_id, to_local(firstEnemy.global_position))
		animationPlayer.play("attack")

		firstEnemy.get_owner().dealDamage(damage)
		sprite.modulate = Color(1, 0, 0, 1)
		attackTimer.start(4)
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


func createSubstitute(oldPawn: Horse):
	var newPawn = load("res://src/main/ChessPieces/Horse.tscn").instantiate()

	newPawn.startSpace = oldPawn.startSpace
	newPawn.rest_point = oldPawn.rest_point
	newPawn.global_position = Vector2(200, -56)
	newPawn.canBeMoved = true

	oldPawn.get_parent().add_child(newPawn)


func _on_mouse_entered():
	panel.show()


func _on_mouse_exited():
	panel.hide()