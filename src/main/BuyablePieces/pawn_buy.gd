extends CharacterBody2D

var dragging: bool = false
var rest_point
var rest_nodes = []


func _physics_process(delta):
	if dragging:
		var mousepos = get_global_mouse_position()
		position = lerp(global_position, mousepos, 25 * delta)


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if (event is InputEventMouseButton):
		if (event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
			dragging = true
		if (event.button_index == MOUSE_BUTTON_LEFT and !event.pressed):
			dragging = false