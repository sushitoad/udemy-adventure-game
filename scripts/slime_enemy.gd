extends CharacterBody2D

@export var maxHP: int = 1
@export var moveSpeed: float = 30
var currentHP: int
var target: Node2D

func _ready() -> void:
	currentHP = maxHP

func _physics_process(delta: float) -> void:
	if target:
		var distance: Vector2 = (target.global_position - global_position).normalized()
		velocity = distance * moveSpeed
	
	move_and_slide()

func TakeDamage(damage: int):
	currentHP -= damage
	if currentHP <= 0:
		$DeathSound.play()

func _on_death_sound_finished() -> void:
	call_deferred("queue_free")

func _on_los_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body
