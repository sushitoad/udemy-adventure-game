extends StaticBody2D

var playerInRange: bool = false
@export var sentences: String

func _ready() -> void:
	StopTalking()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and playerInRange:
			Talk(sentences)

func Talk(words: String):
	$CanvasLayer.visible = !$CanvasLayer.visible
	$CanvasLayer/DialogueText.text = words
	
func StopTalking():
	$CanvasLayer.visible = false
