extends CharacterBody2D

@onready var animSprite = $AnimatedSprite2D

@export var moveSpeed: float = 100
@export var HP: int = 10

func _ready() -> void:
	pass

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
	move_and_slide()
	
