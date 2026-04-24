extends Node2D

var spawnPoint: Vector2
var spawnIndex: int = 0

var playerCurrentHP: int = 4

var openedChests: Array[String] = []

func _ready() -> void:
	pass
	#spawnPoint = find_node_in_scene("Player").position
