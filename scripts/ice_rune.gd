extends Area2D

#detect when a block passes over this
#replace that block with an ice block in the same location
#gray itself out maybe?


func _on_body_entered(body: Node2D) -> void:
	print("something passed over me")
