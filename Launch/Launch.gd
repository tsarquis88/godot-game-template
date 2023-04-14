extends ColorRect

const INIT_MUSIC = "init.ogg"

@export var nextScene = "res://SplashScreen/SplashScreen.tscn"
@onready var Game = get_parent()


func _ready():
	SfxManager.playMusic(INIT_MUSIC)
	Game.emit_signal("ChangeScene", nextScene, GameSettings.TRANSITIONS.FADE_SCREEN)

	Logger.logDebug("Launch: Ready")
