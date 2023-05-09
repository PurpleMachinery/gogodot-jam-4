extends Label


@onready var root: LessIsMore = get_tree().get_current_scene()


func _process(_delta):
	text = String.num(root.playerCoins)
