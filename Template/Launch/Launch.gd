extends ColorRect

const INIT_MUSIC = "init.ogg"

@export var m_next_scene = "res://Template/SplashScreen/SplashScreen.tscn"
@onready var m_game = get_parent()


func _ready():
	SfxManager.play_music(INIT_MUSIC)
	m_game.emit_signal("change_scene", m_next_scene, GameSettings.TRANSITIONS.FADE_SCREEN)

	Logger.log_debug("Launch: Ready")
