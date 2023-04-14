extends Node2D

@export var nextScene = "res://MainMenu/MainMenu.tscn"
@export var duration = 3
@onready var lostLabel = find_child("LostLabel")
@onready var background = find_child("Background")
@onready var Game = get_parent()

var timer


func _ready():
	background.color = Settings.MENU_BACKGROUND_COLOR
	lostLabel.text = tr("LOST-MESSAGE")
	timer = GlobalTimer.create_timeout(self.finish, duration, true, true)

	Logger.logDebug("LostScreen: Ready")


func finish():
	GlobalTimer.delete_timeout(timer)
	Game.emit_signal("ChangeScene", nextScene, GameSettings.TRANSITIONS.UP_BOTTOM)
