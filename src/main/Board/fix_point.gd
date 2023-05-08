extends Marker2D
class_name FixPoint

@export var canBeUsed: bool = true

var currentPawn = null


func _on_draw():
	# draw_circle(Vector2.ZERO, 5, Color.BLANCHED_ALMOND)
	pass


func select(pawn):
	if(canBeUsed):
		canBeUsed = false
		for child in get_tree().get_nodes_in_group("zone"):
			if(pawn == child.currentPawn):
				child.deselect()

		currentPawn = pawn
		# modulate = Color.RED


func deselect():
	# modulate = Color.WHITE
	canBeUsed = true
	currentPawn = null
