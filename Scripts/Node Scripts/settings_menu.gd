extends Control

@onready var vibration_toggle: CheckButton = %VibrationToggle
@onready var haptic_slider: HSlider = %HapticSlider

@onready var master_slider: HSlider = %MasterSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider

@onready var brightness_slider: HSlider = %BrightnessSlider

@onready var camera_effects_toggle: CheckButton = %CameraEffectsToggle

@onready var glitch_slider: HSlider = %GlitchSlider

@onready var reduce_flashing_toggle: CheckButton = %ReduceFlashingToggle

@onready var pause_menu: Control = $"../PauseMenu"


func _ready() -> void:
	hide()
	load_saved_values_into_menu()
	
func load_saved_values_into_menu()-> void:
	vibration_toggle.button_pressed = SettingsManager.vibration_enabled
	
	haptic_slider.value = SettingsManager.haptic_strength
	
	master_slider.value = SettingsManager.master_volume
	
	music_slider.value = SettingsManager.music_volume
	
	sfx_slider.value = SettingsManager.sfx_volume
	
	brightness_slider.value = SettingsManager.brightness
	
	camera_effects_toggle.button_pressed = SettingsManager.camera_effects_enabled
	
	glitch_slider.value = SettingsManager.glitch_intensity
	
	reduce_flashing_toggle.button_pressed = SettingsManager.reduce_flashing
	
func open_menu() -> void:
	load_saved_values_into_menu()
	show()
	
func close_menu() -> void:
	SettingsManager.save_settings()
	hide()
	
func _on_vibration_toggle_toggled(enabled:bool) -> void:
	SettingsManager.vibration_enabled = enabled
	
	if enabled:
		HapticsManager.ui_press()
		
func _on_haptic_slider_value_changed(value : float) -> void:
	SettingsManager.haptic_strength = value
	
func _on_master_slider_value_changed(value:float) -> void:
	AudioManager.set_master_volume(value)
	
func _on_music_slider_value_changed(value:float) -> void:
	AudioManager.set_music_volume(value)
	
func _on_sfx_slider_value_changed(value:float)-> void:
	AudioManager.set_sfx_volume(value)
	
func _on_brightness_slider_value_changed(value:float) -> void:
	SettingsManager.brightness = value
	
	get_tree().call_group("brightness_controller", "apply_brightness", value)
	
func _on_camera_effects_toggle_toggled(enabled : bool) -> void:
	SettingsManager.camera_effects_enabled = enabled
	
func _on_glitch_slider_value_changed(value:float) -> void:
	SettingsManager.glitch_intensity = value

func _on_reduce_flashing_toggle_toggled(enabled : bool) -> void:
	SettingsManager.reduce_flashing = enabled
	
func _on_back_button_pressed() -> void:
	HapticsManager.ui_press()
	close_menu()
	pause_menu.return_from_settings()
	
	
	
	
	
