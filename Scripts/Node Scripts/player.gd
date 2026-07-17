extends CharacterBody2D

@onready var jump_buffer_timer : Timer = $JumpBufferTimer
@onready var player_sprite : Sprite2D = $PlayerSprite
@export var jump_force : float = 500
@export var gravity : float = 2200

var jump_input : bool = false
var glitch_tween : Tween
var sprite_start_position: Vector2
var sprite_start_scale: Vector2

func _ready():
	sprite_start_position = player_sprite.position
	sprite_start_scale= player_sprite.scale

func _physics_process(delta: float):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if jump_input and is_on_floor():
		jump_input = false
		velocity.y = -jump_force
		_play_glitch_jump()
		
		
	move_and_slide()
	
func _play_glitch_jump():
	if glitch_tween:
		glitch_tween.kill()
	player_sprite.position = sprite_start_position
	player_sprite.scale = sprite_start_scale
	player_sprite.modulate = Color.WHITE
	player_sprite.visible = true
	
	glitch_tween = create_tween()
	#brief compression before the visual corruption.
	glitch_tween.tween_property(player_sprite, "scale", Vector2(sprite_start_scale.x * 1.25, sprite_start_scale.y * 0.7), 0.025)
	#first sideways visual displacement
	glitch_tween.tween_property(player_sprite, "position", sprite_start_position + Vector2(7, -2), 0.02)
	glitch_tween.parallel().tween_property(player_sprite, "modulate", Color(0.2, 1.0, 1.0, 1.0), 0.02)
	# Flicker out.
	glitch_tween.tween_callback(func(): player_sprite.visible = false)
	glitch_tween.tween_interval(0.025)
	#Reappear displaced in the opposite direction
	glitch_tween.tween_callback(
		func(): 
			player_sprite.visible = true
			player_sprite.position = sprite_start_position + Vector2(-6,1)
			player_sprite.modulate = Color(1.0, 0.2, 0.8, 1.0)
			)
	glitch_tween.tween_interval(0.025)
	
	# Stretch vertically as the player launches
	glitch_tween.tween_property(
		player_sprite, "scale", Vector2(sprite_start_scale.x * 0.75, sprite_start_scale.y *1.35),0.04)
	
	#Restore everything
	glitch_tween.tween_property(
		player_sprite, "position", sprite_start_position, 0.05
	)
	glitch_tween.parallel().tween_property(
		player_sprite, "scale", sprite_start_scale, 0.05
	)
	glitch_tween.parallel().tween_property(
		player_sprite,
		"modulate",
		Color.WHITE,
		0.05
	)
	glitch_tween.tween_callback(
		func(): player_sprite.visible = true
	)


func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				_try_jump()
	
	if event is InputEventScreenTouch:
		if event.pressed:
			_try_jump()



func _try_jump(): #will need things adding
	
	if GameManager.is_game_over:
		return
	
	jump_input = true
	jump_buffer_timer.start()
	
func _on_jump_buffer_timer_timeout():
	jump_input = false


func _on_obstacle_detector_body_entered(body: Node2D) -> void:
	
	if GameManager.is_game_over:
		return
	
	if body.is_in_group("Obstacles"):
		GameManager.end_game()
		velocity.x = -500
		velocity.y = -jump_force 
