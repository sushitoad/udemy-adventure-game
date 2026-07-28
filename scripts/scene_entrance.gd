extends Area2D

@export var sceneToLoad: String
@export var spawnPoint: Vector2
##Input the string for the move anim the player should have upon entering the new area
@export var spawnPlayerFacing: String


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		SceneManager.spawnPoint = spawnPoint
		SceneManager.spawnPlayerFacing = spawnPlayerFacing
		if sceneToLoad != null:
			get_tree().change_scene_to_file.call_deferred(sceneToLoad)
