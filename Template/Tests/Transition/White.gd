extends ColorRect

var m_game


func _ready():
	m_game = get_parent()
	GlobalTimer.create_timeout(self.changeScene, 1)


func change_scene():
	m_game.emit_signal(
		"change_scene", "res://Template/Tests/Transition/Red.tscn", GameSettings.TRANSITIONS.FADE_SCREEN
	)
