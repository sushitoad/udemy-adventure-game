extends Control

#this should be opened by a game manager
#the game manager would then pause the game with get_tree().paused = true


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_resume_pressed() -> void:
	pass # Replace with function body.
	#resume will unpause game and hide this menu
