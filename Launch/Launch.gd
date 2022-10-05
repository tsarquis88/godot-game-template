extends ColorRect


@export var nextScene = "res://SplashScreen/SplashScreen.tscn"
@onready var Game = get_parent()


func _ready():
	Game.emit_signal("ChangeScene", nextScene, GameSettings.TRANSITIONS.FADE_SCREEN)
