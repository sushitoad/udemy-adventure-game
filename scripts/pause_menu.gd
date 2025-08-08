extends Control

#this should be opened by a game manager
#the game manager would then pause the game with get_tree().paused = true

func _ready() -> void:
	$CanvasLayer.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Quit"):
		if $CanvasLayer.visible == true:
			Resume()
		else:
			get_tree().paused = true
			$CanvasLayer.visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_resume_pressed() -> void:
	Resume()
	#resume will unpause game and hide this menu

func Resume():
	get_tree().paused = false
	$CanvasLayer.visible = false
