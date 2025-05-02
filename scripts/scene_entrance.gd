extends Area2D

@export var sceneToLoad: String
@export var spawnPoint: Vector2
@export var spawnIndex: int = 0


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		#SceneManager.spawnPoint = spawnPoint
		SceneManager.spawnIndex = spawnIndex
		if sceneToLoad != null:
			get_tree().change_scene_to_file.call_deferred(sceneToLoad)
