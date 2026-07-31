extends Node2D

var spawnPoint: Vector2
var spawnPlayerFacing: String
#reference to the position the player should spawn in if dead
var activeShrinePosition: Vector2
##reference to the index from the gameSceneList array that the player should spawn into
var shrineSceneIndex: int
var gameSceneList: Array[PackedScene] = [preload("res://scenes/game_scene.tscn"), preload("res://scenes/cave_scene.tscn")]

var playerCollectedHearts: int = 3

var playerCurrentHP: int = 4

var openedChests: Array[String] = []

func _ready() -> void:
	playerCurrentHP = playerCollectedHearts * 2

func RespawnAtNearestShrine():
	get_tree().change_scene_to_packed(gameSceneList[shrineSceneIndex])
	spawnPoint = activeShrinePosition
	playerCurrentHP = playerCollectedHearts * 2
