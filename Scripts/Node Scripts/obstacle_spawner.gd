extends Node2D

@export var scenes_to_spawn: Array[PackedScene]
@export var min_spawn_range: int
@export var max_spawn_range: int

var next_spawn_range : float

var previous_object : Node2D

func _process(delta):
	
	if not previous_object:
		_spawn()
		return
	
	if global_position.x - previous_object.global_position.x > next_spawn_range:
		_spawn()

func _spawn():
	
	var scene_to_spawn : PackedScene = scenes_to_spawn[randi() % len(scenes_to_spawn)]
	var obj: Node2D = scene_to_spawn.instantiate()
	add_child(obj)
	obj.global_position = global_position
	next_spawn_range = randi_range(min_spawn_range, max_spawn_range)
	previous_object = obj
