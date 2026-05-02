extends CharacterBody2D
class_name Player

@onready var animSprite = $AnimatedSprite2D

@export var moveSpeed: float = 100
@export var HP: int = 10
@export var spawnPoints: PackedVector2Array
@export var pushStrength: float = 80
@export var heartUI: Array[AnimatedSprite2D]
var maxHP: int

signal player_died

func _ready() -> void:
	#position = SceneManager.spawnPoint
	position = spawnPoints[SceneManager.spawnIndex]
	UpdateTreasureLabel()
	#connect UpdateTreasureLabel to all the chestOpened signals instead of using physics process
	maxHP = SceneManager.playerCollectedHearts * 2
	#SceneManager.playerCurrentHP = maxHP
	updateHeartDisplay()
	updatePlayerHP()

func _physics_process(delta: float) -> void:
	movePlayer()
	pushBlocks()
	UpdateTreasureLabel()
	if Input.is_action_just_pressed("Interact"):
		Attack()
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

func _on_hitbox_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		TakeDamage(1)

func TakeDamage(damage: int):
	SceneManager.playerCurrentHP -= damage
	$HurtSound.play()
	if SceneManager.playerCurrentHP <= 0:
		player_died.emit()
		SceneManager.playerCurrentHP = SceneManager.playerCollectedHearts * 2
		get_tree().call_deferred("reload_current_scene")
	updatePlayerHP()

func updatePlayerHP():
	var hp: int = SceneManager.playerCurrentHP
	var reachedHP: bool = false
	var counter: int = 0
	for heart in heartUI:
		counter += 2
		if !reachedHP:
			if counter < hp:
				heart.play("full")
			elif counter == hp:
				heart.play("full")
				reachedHP = true
			elif counter > hp:
				heart.play("half")
				reachedHP = true
		else: heart.play("empty")

#call after changing number of collected hearts
func updateHeartDisplay():
		for heart in heartUI:
			if heartUI.find(heart) < SceneManager.playerCollectedHearts:
				heart.visible = true
			else: heart.visible = false

func Attack():
	$Sword.visible = true
	$Sword/SwordArea2D.monitoring = true
	$Sword/AttackTimer.start()

func _on_attack_timer_timeout() -> void:
	$Sword.visible = false
	$Sword/SwordArea2D.monitoring = false

func _on_sword_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.queue_free()
