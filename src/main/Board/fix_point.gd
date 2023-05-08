extends Marker2D
class_name FixPoint

func _on_draw():
	draw_circle(Vector2.ZERO, 5, Color.BLANCHED_ALMOND)


func select():
	for child in get_tree().get_nodes_in_group("zone"):
		child.deselect()
	modulate = Color.RED

func deselect():
	modulate = Color.WHITE