extends StaticBody2D

var buttonsPressed: int = 0
@export var buttonsToOpen: int = 1

func _on_puzzle_button_pressed() -> void:
	buttonsPressed += 1
	if buttonsPressed >= buttonsToOpen:
		visible = false
		$CollisionShape2D.set_deferred("disabled", true)

func _on_puzzle_button_unpressed() -> void:
	buttonsPressed -= 1
	if buttonsPressed < buttonsToOpen:
		visible = true
		$CollisionShape2D.set_deferred("disabled", false)
