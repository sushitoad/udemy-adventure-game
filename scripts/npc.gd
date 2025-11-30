extends StaticBody2D

var playerInRange: bool = false
@export var characterName: String
@export var sentences: Array[String]
var sentenceIndex: int = 0

func _ready() -> void:
	StopTalking()
	$CanvasLayer/CharacterName.text = characterName

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and playerInRange:
			if sentenceIndex == sentences.size():
				StopTalking()
			else:
				$AudioStreamPlayer2D.play()
				Talk(sentences[sentenceIndex])
				sentenceIndex += 1

func Talk(words: String):
	$CanvasLayer.visible = true
	$CanvasLayer/DialogueText.text = words
	
func StopTalking():
	$CanvasLayer.visible = false
	sentenceIndex = 0
