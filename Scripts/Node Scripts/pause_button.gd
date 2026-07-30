extends TextureButton


@onready var pause_menu: Control = $"../../PauseMenu"


func _process(_delta: float) -> void:
	if GameManager.is_game_over \
	or GameManager.is_ending_game:
		hide()
	else:
		show()


func _on_button_down() -> void:
	if GameManager.is_game_over \
	or GameManager.is_ending_game:
		return

	HapticsManager.ui_press()
	pause_menu.open_pause_menu()
	
