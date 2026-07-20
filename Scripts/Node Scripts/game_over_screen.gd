extends TextureRect

@onready var you_survived_text : Label = $YouSurvivedText
@onready var high_score_text: Label = $HighScoreText
@onready var new_high_score_text: Label = $NewHighScoreText

func _ready() -> void:
	hide()
	
	GameManager.game_over.connect(_on_game_over)
	GameManager.game_started.connect(_on_game_started)
	
	
func _on_game_started() -> void:
	hide()
	
func _on_game_over() -> void:
	you_survived_text.text = "YOU SURVIVED: %dm" % int(GameManager.distance)
	high_score_text.text = "BEST: %dm" % SaveManager.high_score
	new_high_score_text.visible = GameManager.got_new_high_score
	show()
