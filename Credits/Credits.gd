extends Node2D

@export var returnScene = "res://MainMenu/MainMenu.tscn"
@onready var creditsLabel = find_child("CreditsLabel")
@onready var Game = get_parent()

func _ready():
	var config = ConfigFile.new()
	var err = config.load("res://config.cfg")

	if err != OK:
		return

	creditsLabel.text = str(tr("CREDITS"), "\n\n")
	for credit in config.get_section_keys("credits"):
		creditsLabel.text += str(tr(credit), " ", tr("BY"), " ", config.get_value("credits", credit), "\n")

func _input(event):
	if event is InputEventKey and event.pressed:
		Game.emit_signal("ChangeScene", returnScene, GameSettings.TRANSITIONS.LEFT_RIGHT)
