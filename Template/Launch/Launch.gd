extends ColorRect

@export var m_next_scene = "res://Template/SplashScreen/SplashScreen.tscn"
@onready var m_init_music = load("res://Template/Assets/Music/init.ogg")
@onready var m_game = get_parent()


func _ready():
	SfxManager.play_music(m_init_music)
	m_game.emit_signal("change_scene", m_next_scene, GameSettings.TRANSITIONS.FADE_SCREEN)

	Logger.log_debug("Launch: Ready")
