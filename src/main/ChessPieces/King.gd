extends Node2D

@export var health: int = 20;

func dealDamage(damage: int):
    health -= damage