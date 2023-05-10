extends Button


@onready var root: LessIsMore = get_tree().get_current_scene()


func _process(_delta):
	disabled = !root.canCallNextWave

func _on_pressed():
	root.runNextRound()
