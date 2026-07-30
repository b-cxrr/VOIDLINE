extends Node

func vibrate(duration_ms: int, base_strength: float) -> void:
	if not SettingsManager.vibration_enabled:
		return
		
	var final_strength := clampf(base_strength * SettingsManager.haptic_strength, 0.0, 1.0)
	
	Input.vibrate_handheld(duration_ms, final_strength)

func jump() -> void:
	vibrate(25, 0.20)
	
func landing() -> void:
	vibrate(45, 0.35)
	
func death() -> void:
	vibrate(140, 0.85)
	
func ui_press() -> void:
	vibrate(20, 0.15)
