extends StaticBody2D

#interactable - needs Interact() func



func Interact():
	$ActivateSound.play()
	SceneManager.activeShrinePosition = $SpawnPoint.global_position
