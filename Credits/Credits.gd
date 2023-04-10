extends Node2D

@export var returnScene = "res://MainMenu/MainMenu.tscn"
@onready var creditsLabel = find_child("CreditsLabel")
@onready var background = find_child("Background")
@onready var Game = get_parent()

func _ready():
	background.color = Settings.MENU_BACKGROUND_COLOR
	creditsLabel.text = str(tr("CREDITS"), "\n\n")
	for credit in GameSettings.getSectionKeys("credits"):
		creditsLabel.text += str(tr(credit), " ", tr("BY"), " ", GameSettings.getSetting("credits", credit), "\n")
	
	Logger.logDebug("Credits: Ready")


func _input(event):
	if event is InputEventKey and event.pressed:
		Game.emit_signal("ChangeScene", returnScene, GameSettings.TRANSITIONS.LEFT_RIGHT)
