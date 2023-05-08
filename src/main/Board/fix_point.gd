extends Marker2D
class_name FixPoint

#@export var occupied: bool = false

var currentPawn = null


func _on_draw():
	draw_circle(Vector2.ZERO, 5, Color.BLANCHED_ALMOND)


func select(pawn):
	for child in get_tree().get_nodes_in_group("zone"):
		if(pawn == child.currentPawn):
			child.deselect()
			child.selectNextInventoryEmpty()

	currentPawn = pawn
	modulate = Color.RED


func deselect():
	modulate = Color.WHITE
	currentPawn = null


func selectNextInventoryEmpty():
	print("Ainda precisa ser implementado")
