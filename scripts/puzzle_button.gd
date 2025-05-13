extends Area2D

var bodiesOnTop: int = 0

func _on_body_entered(body: Node2D) -> void:
	bodiesOnTop += 1
	if bodiesOnTop == 1:
		$AnimatedSprite2D.play("pressed")
		print("button pressed")

func _on_body_exited(body: Node2D) -> void:
	bodiesOnTop -= 1
	if bodiesOnTop == 0:
		$AnimatedSprite2D.play("unpressed")
		print("button unpressed")
