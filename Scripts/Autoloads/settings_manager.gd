extends Node

const SETTINGS_PATH:= "user://settings.cfg"

# Haptics
var vibration_enabled: bool = true
var haptic_strength:float = 1.0


# Audio
var master_volume: float = 1.0
var music_volume: float = 0.8
var sfx_volume: float = 1.0
var ui_volume: float = 1.0

# Display
var brightness: float = 1.0

# Accessibility / effects
var camera_effects_enabled: bool = true
var glitch_intensity: float = 1.0
var reduce_flashing: bool = false

func _ready() -> void:
	load_settings()
	apply_all_settings()
	
func save_settings() -> void:
	var config := ConfigFile.new()
	
	config.set_value("haptics", "enabled", vibration_enabled)
	config.set_value("haptics","strength", haptic_strength)
	
	
	config.set_value("audio", "master", master_volume)
	config.set_value("audio","music", music_volume)
	config.set_value("audio","sfx",sfx_volume)
	config.set_value("audio","ui", ui_volume)
	
	config.set_value("display","brightness",brightness)
	
	config.set_value("accessibility","camera_effects",camera_effects_enabled)
	config.set_value("accessibility","glitch_intensity", glitch_intensity)
	config.set_value("accessibility", "reduce_flashing", reduce_flashing)
	
	var error:= config.save(SETTINGS_PATH)
	
	if error != OK:
		push_error("Settings could not be saved. Error: %s" % error)
	

func load_settings()-> void:
	var config := ConfigFile.new()
	var error := config.load(SETTINGS_PATH)
	
	if error != OK:
		return
	
	vibration_enabled = bool( config.get_value("haptics", "enabled", vibration_enabled))
	haptic_strength = float( config.get_value( "haptics", "strength", haptic_strength))
	master_volume = float( config.get_value("audio","master", master_volume))
	music_volume= float(config.get_value("audio","music",music_volume))
	sfx_volume = float(config.get_value("audio", "sfx", sfx_volume))
	ui_volume = float( config.get_value("audio", "ui", ui_volume))
	brightness = float(config.get_value("display","brightness",brightness))
	camera_effects_enabled = bool (config.get_value("accessibility", "camera_effects", camera_effects_enabled))
	glitch_intensity = float( config.get_value("accessibility","glitch_intensity", glitch_intensity))
	reduce_flashing = bool(config.get_value("accessibility","reduce_flashing", reduce_flashing))
	
func apply_all_settings() -> void:
	set_bus_volume("Master", master_volume)
	set_bus_volume("Music", music_volume)
	set_bus_volume("SFX", sfx_volume)
	set_bus_volume("UI", ui_volume)
	
func set_bus_volume(bus_name : StringName, volume: float) -> void:
	var bus_index := AudioServer.get_bus_index(bus_name)
	
	if bus_index == -1:
		push_warning ("Audio bus does not exist: %s" % bus_name)
		return
	
	AudioServer.set_bus_volume_linear(bus_index, clampf(volume, 0.0, 1.0))
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_PAUSED:
		save_settings()
	
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_settings()
	
	
	
	
	
	
	
	
	
	
	
	
	
	
