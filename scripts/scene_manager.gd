extends Node2D

var spawnPoint: Vector2
var spawnPlayerFacing: String
#reference to the position the player should spawn in if dead
var activeShrinePosition
##reference to the index from the gameSceneList array that the player should spawn into
var shrineSceneIndex
var sceneToLoadOnRespawn: PackedScene

var playerCollectedHearts: int = 3

var playerCurrentHP: int = 4

var openedChests: Array[String] = []

func _ready() -> void:
	playerCurrentHP = playerCollectedHearts * 2
	#spawnPoint = find_node_in_scene("Player").position

func RespawnAtNearestShrine():
	#load the scene that matches the shrineSceneIndex in the array of scenes
	get_tree().change_scene_to_packed(sceneToLoadOnRespawn)
	#set the player character to activeShrinePosition
	var player: Node2D = get_tree().get_first_node_in_group("player")
	player.global_position = activeShrinePosition
	#set them to full health
	playerCurrentHP = playerCollectedHearts * 2
