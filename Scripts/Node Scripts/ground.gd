extends StaticBody2D

@export var start : float
@export var end : float

func _process(delta):
	var speed : float = GameManager.current_speed * delta
	global_position += Vector2.LEFT * speed
	
	if global_position.x < end:
		global_position.x = start
