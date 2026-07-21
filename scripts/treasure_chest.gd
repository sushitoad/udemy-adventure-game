extends StaticBody2D

#interactable - needs Interact() func
@export var chestName: String

@onready var sprite = $AnimatedSprite2D
@onready var scrollTimer = $Timer
@onready var scrollSprite = $Sprite2D
var opened: bool = false

signal chestOpened

func _ready() -> void:
	if SceneManager.openedChests.has(chestName):
		opened= true
	if !opened:
		sprite.play("closed")
	else:
		sprite.play("open")

func Interact():
	if !opened:
			OpenChest()

func OpenChest():
	sprite.play("open")
	opened = true
	$UnlockSound.play()
	scrollTimer.start()
	$AnimationPlayer.play("collectScroll")
	SceneManager.openedChests.append(chestName)
	chestOpened.emit()
