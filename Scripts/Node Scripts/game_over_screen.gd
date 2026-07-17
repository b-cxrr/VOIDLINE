extends TextureRect

@onready var you_survived_text : Label = $YouSurvivedText

func _ready() -> void:
	hide()
	
	GameManager.game_over.connect(_on_game_over)
	GameManager.game_started.connect(_on_game_started)
	
	
func _on_game_started() -> void:
	hide()
	
func _on_game_over() -> void:
	you_survived_text.text = ("YOU SURVIVED: " + str(int(GameManager.distance)) + "m")
	show()
