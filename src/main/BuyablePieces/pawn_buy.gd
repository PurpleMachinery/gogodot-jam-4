extends CharacterBody2D

var dragging: bool = false
var rest_point
var rest_nodes = []


func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zone")
	rest_point = rest_nodes[0].global_position
	rest_nodes[0].select(self)


func _physics_process(delta):
	if dragging:
		var mousepos = get_global_mouse_position()
		global_position = lerp(global_position, mousepos, 20 * delta)
	else:
		global_position = lerp(global_position, rest_point, 5 * delta)


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if (event is InputEventMouseButton):
		if (event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
			dragging = true
		if (event.button_index == MOUSE_BUTTON_LEFT and !event.pressed):
			dragging = false
			var shortest_dist = 6
			for child in rest_nodes:
				var distance = global_position.distance_to(child.global_position)
				if(distance < shortest_dist):
					child.select(self)
					rest_point = child.global_position
