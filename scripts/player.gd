extends CharacterBody2D
class_name Player

@onready var animSprite = $AnimatedSprite2D

@export var moveSpeed: float = 100
@export var HP: int = 10
@export var spawnPoints: PackedVector2Array
@export var pushStrength: float = 80

func _ready() -> void:
	#position = SceneManager.spawnPoint
	position = spawnPoints[SceneManager.spawnIndex]

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	var moveVector: Vector2 = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	velocity = moveVector * moveSpeed
	if velocity.x > 0:
		animSprite.play("moveRight")
	elif velocity.x < 0:
		animSprite.play("moveLeft")
	elif velocity.y > 0:
		animSprite.play("moveDown")
	elif velocity.y < 0:
		animSprite.play("moveUp")
	else:
		animSprite.stop()
		
	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision:
		var colliderNode = collision.get_collider()
		if colliderNode is RigidBody2D:
			var collisionNormal: Vector2 = collision.get_normal()
			colliderNode.apply_central_force(-collisionNormal * pushStrength)
		
	move_and_slide()
	
