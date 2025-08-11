extends StaticBody2D

var playerInRange: bool = false
@onready var sprite = $AnimatedSprite2D
signal on
signal off

@export var isOn: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and playerInRange:
		isOn = !isOn
		if isOn:
			sprite.play("on")
			on.emit()
		else:
			sprite.play("off")
			off.emit()
