extends Control

@onready var settings_menu: Control = $"../SettingsMenu"

func _ready() -> void:
	hide()

func open_pause_menu() -> void:
	get_tree().paused = true
	show()
	
func _on_resume_button_pressed() -> void:
	HapticsManager.ui_press()
	hide()
	get_tree().paused = false
	
func _on_settings_button_pressed() -> void:
	HapticsManager.ui_press()
	hide()
	settings_menu.open_menu()
	
func return_from_settings() -> void:
	show()
	
