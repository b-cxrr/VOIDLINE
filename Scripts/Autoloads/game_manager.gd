extends Node


var starting_speed : float = 200
var current_speed: float = starting_speed
var max_speed: float = 1500
var speed_increase_rate : float = 5
var distance : float = 0
var is_game_over : bool = false





func _process(delta):
	if is_game_over:
		return

	if current_speed < max_speed:
		current_speed += speed_increase_rate * delta
		current_speed = min(current_speed,max_speed)
	distance += current_speed / 32 * delta
	
	


func start_game() -> void:
	current_speed = starting_speed
	distance = 0.0
	is_game_over = false
	
func end_game():
	is_game_over = true
	current_speed = 0.0
