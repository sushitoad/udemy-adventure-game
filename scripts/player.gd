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
	UpdateTreasureLabel()
	#connect UpdateTreasureLabel to all the chestOpened signals instead of using physics process

func _physics_process(delta: float) -> void:
	#if Input.is_action_just_pressed("Quit"):
		#get_tree().quit()
	movePlayer()
	pushBlocks()
	UpdateTreasureLabel()
	move_and_slide()
	
func movePlayer():
	var moveVector: Vector2 = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	velocity = moveVector * moveSpeed
	if velocity.x > 0:
		animSprite.play("moveRight")
		$InteractArea2D.position = Vector2(10, 0)
		$InteractArea2D.rotation_degrees = 90
	elif velocity.x < 0:
		animSprite.play("moveLeft")
		$InteractArea2D.position = Vector2(-10, 0)
		$InteractArea2D.rotation_degrees = 90
	elif velocity.y > 0:
		animSprite.play("moveDown")
		$InteractArea2D.position = Vector2(0, 10)
		$InteractArea2D.rotation = 0
	elif velocity.y < 0:
		animSprite.play("moveUp")
		$InteractArea2D.position = Vector2(0, -10)
		$InteractArea2D.rotation = 0
	else:
		animSprite.stop()

func pushBlocks():
	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision:
		var colliderNode = collision.get_collider()
		if colliderNode != null:
			if colliderNode.is_in_group("pushable"):
				var collisionNormal: Vector2 = collision.get_normal()
				colliderNode.apply_central_force(-collisionNormal * pushStrength)

func UpdateTreasureLabel():
	%TreasureLabel.text = str(SceneManager.openedChests.size())

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		body.playerInRange = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		body.playerInRange = false
		if body.is_in_group("npc"):
			body.StopTalking()
