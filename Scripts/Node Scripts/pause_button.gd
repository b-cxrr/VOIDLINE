extends TextureButton

var is_paused : bool = false




func _on_button_down() -> void:
	if Engine.time_scale > 0:
		Engine.time_scale = 0.0
	else: Engine.time_scale = 1.0
