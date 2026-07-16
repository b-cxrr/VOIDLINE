extends Label

func _process(delta: float) -> void:
	text = str(int(GameManager.distance)) + "m"
