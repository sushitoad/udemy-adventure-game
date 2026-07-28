extends Node2D

var spawnPoint: Vector2
var spawnPlayerFacing: String
#reference to the position the player should spawn in if dead
var activeShrinePosition
#reference to the scene from a packedscene array that the player should spawn into
var shrineSceneIndex

var playerCollectedHearts: int = 3

var playerCurrentHP: int = 4

var openedChests: Array[String] = []

func _ready() -> void:
	playerCurrentHP = playerCollectedHearts * 2
	#spawnPoint = find_node_in_scene("Player").position

func RespawnAtNearestShrine():
	pass
	#load the scene that matches the shrineSceneIndex in the array of scenes
	#set the player character to activeShrinePosition
	#set them to full health
