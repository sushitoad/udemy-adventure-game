extends Area2D

@export var sceneToLoad: String


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("entered new scene!")
		if sceneToLoad != null:
			get_tree().change_scene_to_file.call_deferred(sceneToLoad)
