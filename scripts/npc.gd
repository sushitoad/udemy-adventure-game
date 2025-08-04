extends StaticBody2D

var player: CharacterBody2D
@export var talkDistance: float

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	$CanvasLayer.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		var distance = transform.origin.distance_to(player.transform.origin)
		if distance <= talkDistance:
			Talk("nothing")
			print("Hello traveler!")

func Talk(words: String):
	$CanvasLayer.visible = !$CanvasLayer.visible
