extends Node2D

@export var nextScene = "res://MainMenu/MainMenu.tscn"
@export var duration = 3
@onready var wonLabel = find_child("WonLabel")
@onready var background = find_child("Background")
@onready var Game = get_parent()

var timer

func _ready():
	background.color = Settings.MENU_BACKGROUND_COLOR
	wonLabel.text = tr("WON-MESSAGE")
	timer = GlobalTimer.create_timeout(self.finish, duration, true, true)
	
	Logger.logDebug("WonScreen: Ready")


func finish():
	GlobalTimer.delete_timeout(timer)
	Game.emit_signal("ChangeScene", nextScene, GameSettings.TRANSITIONS.UP_BOTTOM)
