extends StaticBody2D

#interactable - needs Interact() func
@onready var sprite = $AnimatedSprite2D
signal on
signal off

@export var isOn: bool = false

func Interact():
	if isOn:
		TurnOffSwitch()
	else:
		TurnOnSwitch()

func TurnOnSwitch():
	isOn = true
	$TurnOnSound2D.play()
	sprite.play("on")
	on.emit()
	
func TurnOffSwitch():
	isOn = false
	$TurnOffSound2D.play()
	sprite.play("off")
	off.emit()
