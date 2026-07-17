extends TextureButton


func _process(delta : float) -> void:
	if GameManager.is_game_over or GameManager.is_ending_game:
		hide()
	else: 
		show()


func _on_button_down() -> void:
	if GameManager.is_game_over or GameManager.is_ending_game:
		return
	if Engine.time_scale > 0:
		Engine.time_scale = 0.0
	else: Engine.time_scale = 1.0
