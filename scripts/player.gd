extends CharacterBody2D
class_name Player

@onready var animSprite = $AnimatedSprite2D

@export var moveSpeed: float = 100
@export var HP: int = 10
@export var pushStrength: float = 80
@export var attackKnockback: float = 150
@export var acceleration: float = 10
@export var heartUI: Array[AnimatedSprite2D]
var maxHP: int
var attacking: bool = false
var inRangeToInteract: bool = false
var currentInteraction: Node2D

signal player_died

func _ready() -> void:
	position = SceneManager.spawnPoint
	animSprite.play(SceneManager.spawnPlayerFacing)
	UpdateTreasureLabel()
	#connect UpdateTreasureLabel to all the chestOpened signals instead of using physics process
	maxHP = SceneManager.playerCollectedHearts * 2
	updateHeartDisplay()
	updatePlayerHP()
	player_died.connect(%LevelMusic.stop)

func _physics_process(delta: float) -> void:
	if SceneManager.playerCurrentHP <= 0:
		return
	movePlayer()
	pushBlocks()
	UpdateTreasureLabel()
	if Input.is_action_just_pressed("Interact"):
		if currentInteraction != null:
			currentInteraction.Interact()
		else:
			#some sort of bug in the cave scene where sword doesn't show up to left and up
			Attack()
	move_and_slide()
	
func movePlayer():
	var moveVector: Vector2 = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	velocity = velocity.move_toward(moveVector * moveSpeed, acceleration)
	if attacking:
		velocity = Vector2.ZERO
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
#okay so we need something that handles this a bit better
#im imagining a facing value that's decided by velocity but also keeps the oldest facing if there's a tie
#so I think I'd want to test to see if there are ever consistent fractional values like 0.4 or if its always pretty much 0 or 1

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
		currentInteraction = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		if currentInteraction == body:
			if currentInteraction.is_in_group("npc"):
				currentInteraction.StopTalking()
			currentInteraction = null

func _on_hitbox_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		if !body.isDying:
			TakeDamage(1)
		if SceneManager.playerCurrentHP <= 0:
			body.ResetTarget()
		var distanceToPlayer: Vector2 = global_position - body.global_position
		var knockbackDirection: Vector2 = distanceToPlayer.normalized()
		velocity += knockbackDirection * body.attackKnockback

func TakeDamage(damage: int):
	SceneManager.playerCurrentHP -= damage
	$HurtSound.play()
	if SceneManager.playerCurrentHP <= 0:
		$AnimatedSprite2D.stop()
		modulate = Color(1, 1, 1, 1)
		$AnimatedSprite2D.play("death")
		$AnimatedSprite2D.animation_finished.connect(SceneManager.RespawnAtNearestShrine)
		player_died.emit()
		$DeathSound.play()
	updatePlayerHP()
	var whiteFlashColor: Color = Color(30, 30, 30)
	var originalColor: Color = modulate
	modulate = whiteFlashColor
	await get_tree().create_timer(0.2).timeout
	modulate = originalColor

func updatePlayerHP():
	var hp: int = SceneManager.playerCurrentHP
	if hp < 0: hp = 0
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
	if not $Sword/AttackTimer.is_stopped():
		return
	attacking = true
	$Sword.visible = true
	$Sword/SwordArea2D.monitoring = true
	$Sword/AttackSound.play()
	$Sword/AttackTimer.start()
	var playerAnim: String = $AnimatedSprite2D.animation
	if playerAnim == "moveRight":
		$AnimatedSprite2D.play("attackRight")
		$AnimationPlayer.play("attackRight")
	elif playerAnim == "moveLeft":
		$AnimatedSprite2D.play("attackLeft")
		$AnimationPlayer.play("attackLeft")
	elif playerAnim == "moveUp":
		$AnimatedSprite2D.play("attackUp")
		$AnimationPlayer.play("attackUp")
	elif playerAnim == "moveDown":
		$AnimatedSprite2D.play("attackDown")
		$AnimationPlayer.play("attackDown")

func _on_attack_timer_timeout() -> void:
	$Sword.visible = false
	$Sword/SwordArea2D.monitoring = false
	attacking = false
	var playerAnim: String = $AnimatedSprite2D.animation
	if playerAnim == "attackRight":
		$AnimatedSprite2D.play("moveRight")
	elif playerAnim == "attackLeft":
		$AnimatedSprite2D.play("moveLeft")
	elif playerAnim == "attackUp":
		$AnimatedSprite2D.play("moveUp")
	elif playerAnim == "attackDown":
		$AnimatedSprite2D.play("moveDown")

func _on_sword_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.TakeDamage(1, self)
