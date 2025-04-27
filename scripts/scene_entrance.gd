extends Area2D

@export var sceneToLoad: PackedScene = null


func _on_body_entered(body: Node2D) -> void:
	print("entered new scene!")
	if sceneToLoad != null:
		get_tree().change_scene_to_packed(sceneToLoad)
