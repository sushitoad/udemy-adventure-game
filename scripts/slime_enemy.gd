extends CharacterBody2D

@export var maxHP: int = 1
var currentHP: int

func _ready() -> void:
	currentHP = maxHP

func TakeDamage(damage: int):
	currentHP -= damage
	if currentHP <= 0:
		$DeathSound.play()

func _on_death_sound_finished() -> void:
	call_deferred("queue_free")
