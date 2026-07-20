extends CharacterBody2D

@onready var landing_particles: GPUParticles2D = $LandingParticles
@onready var animation_player: AnimationPlayer = $PlayerVisual/AnimationPlayer
@onready var jump_buffer_timer : Timer = $JumpBufferTimer
@onready var player_sprite : Node2D = $PlayerVisual
@export var jump_force : float = 500
@export var gravity : float = 2200
var is_dying : bool = false

var jump_input : bool = false
var glitch_tween : Tween
var sprite_start_position: Vector2
var sprite_start_scale: Vector2

func _ready() -> void:
	
	is_dying = false
	
	
	sprite_start_position = player_sprite.position
	sprite_start_scale= player_sprite.scale
	
	player_sprite.visible = true
	player_sprite.modulate = Color.WHITE
	
	animation_player.play("run_improved")

func _physics_process(delta: float) -> void:
	var was_on_floor: = is_on_floor()
	if not is_on_floor():
		velocity.y += gravity * delta

	if not is_dying:
		if jump_input and is_on_floor():
			jump_input = false
			velocity.y = -jump_force
			animation_player.play("Jump")
			_play_glitch_jump()
		
		
	move_and_slide()
	
	if not is_dying and not was_on_floor and is_on_floor():
		animation_player.play("run_improved")
		landing_particles.restart()
	
func _play_glitch_jump() -> void:
	get_tree().call_group("glitch_effects", "play_jump_glitch")
	
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

func _start_glitch_death() -> void:
	
	is_dying = true
	GameManager.begin_game_over()
	
	get_tree().call_group("glitch_effects", "play_death_glitch")
	
	jump_input = false
	jump_buffer_timer.stop()

	# Physical recoil.
	velocity.x = -500.0
	velocity.y = -jump_force * 0.75

	# Stop any jump glitch currently playing.
	if glitch_tween:
		glitch_tween.kill()

	# Reset the sprite before beginning the death effect.
	player_sprite.position = sprite_start_position
	player_sprite.scale = sprite_start_scale
	player_sprite.modulate = Color.WHITE
	player_sprite.visible = true

	glitch_tween = create_tween()

	# Sudden compression on impact.
	glitch_tween.tween_property(
		player_sprite,
		"scale",
		Vector2(
			sprite_start_scale.x * 1.4,
			sprite_start_scale.y * 0.55
		),
		0.04
	)

	# Flash red and jump sideways.
	glitch_tween.parallel().tween_property(
		player_sprite,
		"modulate",
		Color(1.0, 0.15, 0.3, 1.0),
		0.04
	)

	glitch_tween.parallel().tween_property(
		player_sprite,
		"position",
		sprite_start_position + Vector2(10, -3),
		0.04
	)

	# First flicker.
	glitch_tween.tween_callback(
		func(): player_sprite.visible = false
	)

	glitch_tween.tween_interval(0.04)

	glitch_tween.tween_callback(
		func():
			player_sprite.visible = true
			player_sprite.position = sprite_start_position + Vector2(-9, 2)
			player_sprite.modulate = Color(0.2, 1.0, 1.0, 1.0)
	)

	# Second distortion.
	glitch_tween.tween_property(
		player_sprite,
		"scale",
		Vector2(
			sprite_start_scale.x * 0.6,
			sprite_start_scale.y * 1.5
		),
		0.06
	)

	glitch_tween.parallel().tween_property(
		player_sprite,
		"position",
		sprite_start_position + Vector2(5, -1),
		0.06
	)

	# Rapid flicker.
	glitch_tween.tween_callback(
		func(): player_sprite.visible = false
	)

	glitch_tween.tween_interval(0.035)

	glitch_tween.tween_callback(
		func():
			player_sprite.visible = true
			player_sprite.modulate = Color(1.0, 0.2, 0.8, 1.0)
	)

	glitch_tween.tween_interval(0.05)

	# Collapse the sprite before game over.
	glitch_tween.tween_property(
		player_sprite,
		"scale",
		Vector2(
			sprite_start_scale.x * 1.6,
			sprite_start_scale.y * 0.1
		),
		0.08
	)

	glitch_tween.parallel().tween_property(
		player_sprite,
		"modulate:a",
		0.0,
		0.08
	)

	# Wait briefly before showing the GameOverScreen.
	glitch_tween.tween_interval(0.15)

	glitch_tween.tween_callback(
		func(): GameManager.end_game()
	)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				_try_jump()
	
	if event is InputEventScreenTouch:
		if event.pressed:
			_try_jump()



func _try_jump() -> void: #will need things adding
	
	if is_dying:
		return
		
	if GameManager.is_game_over:
		return
	if Engine.time_scale == 0.0:
		return
	
	jump_input = true
	
	jump_buffer_timer.start()
	
func _on_jump_buffer_timer_timeout() -> void:
	jump_input = false


func _on_obstacle_detector_body_entered(body: Node2D) -> void:
	
	if is_dying:
		return
	
	if GameManager.is_game_over:
		return
	
	if body.is_in_group("Obstacles"):
		_start_glitch_death()
