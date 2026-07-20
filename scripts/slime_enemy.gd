extends CharacterBody2D

@export var maxHP: int = 1
@export var moveSpeed: float = 30
@export var attackKnockback: float = 100
var currentHP: int
var target: Node2D

@onready var animSprite: AnimatedSprite2D = $AnimatedSprite2D
@export var acceleration: float = 5

func _ready() -> void:
	currentHP = maxHP

func _physics_process(delta: float) -> void:
	if target:
		chaseTarget()
	animateEnemy()
	
	move_and_slide()

func chaseTarget():
	var distance: Vector2 = (target.global_position - global_position).normalized()
	velocity = velocity.move_toward(distance * moveSpeed, acceleration)

func animateEnemy():
	#this actually has a bug that doesn't handle when they move the exact same amount in each direction
	if abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0:
			animSprite.play("right")
		elif velocity.x < 0:
			animSprite.play("left")
	elif abs(velocity.x) < abs(velocity.y):
		if velocity.y > 0:
			animSprite.play("down")
		elif velocity.y < 0:
			animSprite.play("up")
	else: animSprite.play("idle")

func ResetTarget():
	target = null
	velocity = Vector2.ZERO

func TakeDamage(damage: int, body: Node2D):
	currentHP -= damage
	var distanceToEnemy: Vector2 = global_position - body.global_position
	var knockbackDirection: Vector2 = distanceToEnemy.normalized()
	velocity += knockbackDirection * body.attackKnockback
	if currentHP <= 0:
		$DeathSound.play()

func _on_death_sound_finished() -> void:
	call_deferred("queue_free")

func _on_los_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body
