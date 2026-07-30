extends Node


@onready var camera: Camera2D = $"../Camera2D"
@onready var glitch_overlay: ColorRect = $"../CanvasLayer/GlitchOverlay"

var camera_tween: Tween
var overlay_tween: Tween

var camera_start_offset: Vector2
var glitch_material: ShaderMaterial


func _ready() -> void:
	add_to_group("glitch_effects")

	camera_start_offset = camera.offset
	glitch_material = glitch_overlay.material as ShaderMaterial

	glitch_material.set_shader_parameter("intensity", 0.0)


func play_jump_glitch() -> void:
	_play_camera_jolt(4.0)
	_play_screen_glitch(0.9, 0.16)


func play_death_glitch() -> void:
	_play_camera_jolt(8.0)
	_play_screen_glitch(1.0, 0.35)


func _play_camera_jolt(strength: float) -> void:
	if not SettingsManager.camera_effects_enabled:
		return
	
	strength *= SettingsManager.glitch_intensity
	
	if camera_tween:
		camera_tween.kill()

	camera.offset = camera_start_offset
	camera_tween = create_tween()

	camera_tween.tween_property(
		camera,
		"offset",
		camera_start_offset + Vector2(strength, -strength * 0.5),
		0.015
	)

	camera_tween.tween_property(
		camera,
		"offset",
		camera_start_offset + Vector2(-strength, strength * 0.4),
		0.02
	)

	camera_tween.tween_property(
		camera,
		"offset",
		camera_start_offset,
		0.035
	)


func _play_screen_glitch(
	max_intensity: float,
	duration: float
) -> void:
	max_intensity *= SettingsManager.glitch_intensity
	if overlay_tween:
		overlay_tween.kill()

	glitch_material.set_shader_parameter(
		"glitch_time",
		Time.get_ticks_msec() / 1000.0
	)

	glitch_material.set_shader_parameter(
		"intensity",
		max_intensity
	)

	overlay_tween = create_tween()

	overlay_tween.tween_method(
		_set_glitch_time,
		0.0,
		duration,
		duration
	)

	overlay_tween.parallel().tween_method(
		_set_glitch_intensity,
		max_intensity,
		0.0,
		duration
	)

	overlay_tween.tween_callback(_reset_screen_glitch)


func _set_glitch_time(value: float) -> void:
	glitch_material.set_shader_parameter(
		"glitch_time",
		Time.get_ticks_msec() / 1000.0 + value
	)


func _set_glitch_intensity(value: float) -> void:
	glitch_material.set_shader_parameter(
		"intensity",
		value
	)


func _reset_screen_glitch() -> void:
	glitch_material.set_shader_parameter("intensity", 0.0)
