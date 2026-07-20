extends Node

const SAVE_PATH := "user://save_data.save"

var high_score : int = 0

func _ready() -> void:
	load_data()

func submit_score(score:int) -> bool:
	if score <= high_score:
		return false
	high_score = score
	save_data()
	return true
	
func save_data() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	
	if file == null:
		push_warning("Could not save game data.")
		return
	file.store_var({
		"high_score": high_score
	})
	
func load_data() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
		
	if file == null:
			push_warning("Could not load game data.")
			return
	var data = file.get_var()
	if data is Dictionary:
		high_score = int(data.get("high_score", 0))
