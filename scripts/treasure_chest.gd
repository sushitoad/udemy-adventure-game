extends StaticBody2D

@export var chestName: String

var playerInRange: bool = false
@onready var sprite = $AnimatedSprite2D
@onready var scrollTimer = $Timer
@onready var scrollSprite = $Sprite2D

var opened: bool = false

func _ready() -> void:
	if SceneManager.openedChests.has(chestName):
		opened= true
	if !opened:
		sprite.play("closed")
	else:
		sprite.play("open")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and playerInRange:
		if !opened:
			OpenChest()
			
func OpenChest():
	sprite.play("open")
	opened = true
	scrollTimer.start()
	$AnimationPlayer.play("collectScroll")
	SceneManager.openedChests.append(chestName)
