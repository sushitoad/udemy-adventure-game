extends CharacterBody2D

@export var maxHP: int = 1
var currentHP: int

func _ready() -> void:
	currentHP = maxHP

func TakeDamage(damage: int):
	currentHP -= damage
	if currentHP <= 0:
		call_deferred("queue_free")
