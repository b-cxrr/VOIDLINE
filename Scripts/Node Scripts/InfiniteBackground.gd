extends Node2D

@export var speed_multiplier := 0.1

@onready var sprite1 := get_child(0) as Sprite2D
@onready var sprite2 := get_child(1) as Sprite2D

var sprite_width : float

func _ready():
	sprite_width = sprite1.texture.get_width() * sprite1.scale.x
	
	sprite2.position.x = sprite1.position.x + sprite_width
	
func _process(delta):
	if GameManager.is_game_over:
		return
		
	var movement = GameManager.current_speed * speed_multiplier * delta
	
	sprite1.position.x -= movement
	sprite2.position.x -= movement
	
	if sprite1.position.x <= -sprite_width:
		sprite1.position.x = sprite2.position.x + sprite_width
	if sprite2.position.x <= -sprite_width:
		sprite2.position.x = sprite1.position.x + sprite_width
