extends StaticBody2D

var player: CharacterBody2D
@export var talkDistance: float

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		var distance = transform.origin.distance_to(player.transform.origin)
		#print(distance)
		if distance <= talkDistance:
			print("Hello traveler!")
