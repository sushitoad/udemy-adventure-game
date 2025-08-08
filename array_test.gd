extends Node2D

@export var arr1: Array[int] = [10, 20, 30, 40, 50]

func _ready() -> void:
	var last = arr1.size() - 1
	print(arr1[last])
	
	arr1[2] = 200
	print(arr1)
