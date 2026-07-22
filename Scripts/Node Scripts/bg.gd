extends Node

@onready var far := $FarBuildings
@onready var near := $NearBuildings

@export var far_multiplier := 0.08
@export var near_multiplier := 0.20

func _process(delta):
	if GameManager.is_game_over:
		return
	
	var movement = GameManager.current_speed * delta
	
	far.scroll_offset.x -= movement * far_multiplier
	near.scroll_offset.x -= movement * near_multiplier
