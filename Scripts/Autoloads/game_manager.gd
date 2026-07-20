extends Node

signal game_over
signal game_started

var starting_speed : float = 200
var current_speed: float = starting_speed
var max_speed: float = 1500
var speed_increase_rate : float = 5
var distance : float = 0
var is_game_over : bool = false
var is_ending_game: bool = false
var got_new_high_score: bool = false





func _process(delta):
	if is_game_over or is_ending_game:
		return

	if current_speed < max_speed:
		current_speed += speed_increase_rate * delta
		current_speed = min(current_speed,max_speed)
	distance += current_speed / 32 * delta
	
	


func start_game() -> void:
	current_speed = starting_speed
	distance = 0.0
	is_game_over = false
	is_ending_game = false
	got_new_high_score = false
	game_started.emit()
	
func end_game() -> void:
	if is_game_over:
		return
	is_ending_game = false
	is_game_over = true
	current_speed = 0.0
	got_new_high_score = SaveManager.submit_score(int(distance))
	game_over.emit()

func begin_game_over() -> void:
	if is_game_over or is_ending_game:
		return
	is_ending_game = true
	current_speed = 0.0
	
	
	
