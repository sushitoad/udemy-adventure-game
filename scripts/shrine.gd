extends StaticBody2D

#interactable - needs Interact() func
@export var shrineSceneIndex: int = 0
@export var spawnFacing: String

func Interact():
	$ActivateSound.play()
	SceneManager.activeShrinePosition = $SpawnPoint.global_position
	SceneManager.shrineSceneIndex = shrineSceneIndex
