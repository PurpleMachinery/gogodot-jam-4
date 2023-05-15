extends Node2D


@onready var audioPlayerBefore: AudioStreamPlayer = $AudioStreamPlayer_before_die
@onready var audioPlayerHurt: AudioStreamPlayer = $AudioStreamPlayer_hurt
@onready var audioPlayerAfter: AudioStreamPlayer = $AudioStreamPlayer_after_die

@export var health: int = 5;


func dealDamage(damage: int):
	health -= damage
	if(health <= 0):
		audioPlayerBefore.play()
		await audioPlayerBefore.finished
		audioPlayerHurt.play()
		await audioPlayerHurt.finished
		audioPlayerAfter.play()
		await audioPlayerAfter.finished

		get_tree().change_scene_to_file("res://src/main/game_over.tscn")
	else:
		audioPlayerHurt.play()
