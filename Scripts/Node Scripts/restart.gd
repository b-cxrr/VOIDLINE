extends TextureButton



func _on_button_down() -> void:
	Engine.time_scale = 1.0
	GameManager.start_game()
	get_tree().reload_current_scene()
