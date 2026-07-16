extends StaticBody2D

@export_range(0.0, 1.0) var parallax: float

func _process(delta):
	var speed : float = GameManager.current_speed * delta * parallax
	global_position.x -= speed
	
	if global_position.x < -1200:
		queue_free()
