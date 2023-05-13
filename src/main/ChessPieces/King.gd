extends Node2D

@export var health: int = 20;

func dealDamage(damage: int):
    health -= damage

    if(health <= 0):
        get_tree().change_scene_to_file("res://src/main/game_over.tscn")