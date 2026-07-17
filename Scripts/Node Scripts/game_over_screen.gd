extends TextureRect

@onready var game_over_text : Label = $GameOverText

func _ready():
	hide()
	
	GameManager.game_over.connect(_on_game_over)
	
	
func _on_game_started():
	hide()
	
func _on_game_over():
	game_over_text.text = ("Game Over\n\n" + "YOU SURVIVED: " + str(int(GameManager.distance)) + "m")
	show()
