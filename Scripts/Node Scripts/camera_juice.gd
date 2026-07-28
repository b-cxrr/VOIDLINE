extends Camera2D

@export var landing_bump_distance: float = 15
@export var landing_bump_duration: float = 0.18

var starting_offset: Vector2
var bump_tween : Tween

func _ready() -> void:
	starting_offset = offset
	
	
func play_landing_bump() -> void:
	if bump_tween:
		bump_tween.kill()
		
	offset = starting_offset
		
	bump_tween = create_tween()
		
	bump_tween.tween_property(self, "offset:y", starting_offset.y + landing_bump_distance, landing_bump_duration * 0.35).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		
	bump_tween.tween_property(self, "offset:y", starting_offset.y, landing_bump_duration * 0.65).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
