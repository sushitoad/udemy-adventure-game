extends Area2D

var bodiesOnTop: int = 0
@export var isSingleUse: bool = false
signal pressed
signal unpressed

func _on_body_entered(body: Node2D) -> void:
	bodiesOnTop += 1
	if bodiesOnTop == 1:
		pressed.emit()
		$AudioStreamPlayer2D.pitch_scale = 1.0
		$AudioStreamPlayer2D.play()
		$AnimatedSprite2D.play("pressed")
		#print("button pressed")

func _on_body_exited(body: Node2D) -> void:
	if isSingleUse:
		return
	bodiesOnTop -= 1
	if bodiesOnTop == 0:
		unpressed.emit()
		$AudioStreamPlayer2D.pitch_scale = 0.6
		$AudioStreamPlayer2D.play()
		$AnimatedSprite2D.play("unpressed")
		#print("button unpressed")
