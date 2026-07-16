extends CharacterBody2D

@export var jump_force : float = 500
@export var gravity : float = 2200

@onready var jump_buffer_timer : Timer = $JumpBufferTimer

var jump_input : bool = false

func _physics_process(delta: float):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if jump_input and is_on_floor():
		jump_input = false
		velocity.y = -jump_force
		
		
	move_and_slide()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				_try_jump()
	
	if event is InputEventScreenTouch:
		if event.pressed:
			_try_jump()



func _try_jump(): #will need things adding
	jump_input = true
	jump_buffer_timer.start()
	
func _on_jump_buffer_timer_timeout():
	jump_input = false
