extends Node2D

@export var nextScene = "res://MainMenu/MainMenu.tscn"
@export var duration = 3
@onready var Game = get_parent()

var timer

func _ready():
	timer = GlobalTimer.create_timeout(self.finish, duration, true, true)
	
	Logger.logDebug("SplashScreen: Ready")


func finish():
	GlobalTimer.delete_timeout(timer)
	Game.emit_signal("ChangeScene", nextScene, GameSettings.TRANSITIONS.UP_BOTTOM)
