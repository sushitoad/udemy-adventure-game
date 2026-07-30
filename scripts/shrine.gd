extends StaticBody2D

#interactable - needs Interact() func
#so apparently this doesn't work because it's a circular reference for this to have knowledge of the packed fucking scene fucking stupid bs
@export var gameSceneToLoad: PackedScene
@export var spawnFacing: String

func Interact():
	$ActivateSound.play()
	SceneManager.activeShrinePosition = $SpawnPoint.global_position
	SceneManager.sceneToLoadOnRespawn = gameSceneToLoad
