extends Node

func set_master_volume(value:float) -> void:
	SettingsManager.master_volume = value
	SettingsManager.set_bus_volume("Master", value)
	
func set_music_volume(value:float) -> void:
	SettingsManager.music_volume = value
	SettingsManager.set_bus_volume("Music", value)

func set_sfx_volume(value:float) -> void:
	SettingsManager.sfx_volume = value
	SettingsManager.set_bus_volume("SFX", value)
	
func set_ui_volume(value: float) -> void:
	SettingsManager.ui_volume = value
	SettingsManager.set_bus_volume("UI", value)
