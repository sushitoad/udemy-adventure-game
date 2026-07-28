extends StaticBody2D

#interactable - needs Interact() func



func Interact():
	print("this is a shrine")
	SceneManager.activeShrinePosition = $SpawnPoint.global_position
