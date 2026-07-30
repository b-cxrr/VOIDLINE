extends CanvasModulate

func _ready() -> void:
	add_to_group("brightness_controller")
	apply_brightness(SettingsManager.brightness)
	
func apply_brightness(value:float) -> void:
	var brightness := clampf(value, 0.40, 1.0)
	
	color = Color( brightness,brightness,brightness,1.0)
