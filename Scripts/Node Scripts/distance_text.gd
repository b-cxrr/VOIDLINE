extends Label

func _process(delta: float) -> void:
	text = str(int(GameManager.distance)) + "m"
	
	if GameManager.is_game_over:
		hide()
