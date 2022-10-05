extends BoxContainer


@onready var newGameButton = find_child("NewGameButton")
@onready var optionsButton = find_child("OptionsButton")
@onready var creditsButton = find_child("CreditsButton")
@onready var exitButton = find_child("ExitButton")
@onready var madeWithLabel = find_child("MadeWithLabel")
@onready var Game = get_parent()


func _ready():
	newGameButton.connect("pressed", self.on_newGameButton_pressed)
	optionsButton.connect("pressed", self.on_optionsButton_pressed)
	creditsButton.connect("pressed", self.on_creditsButton_pressed)
	exitButton.connect("pressed", self.on_exitButton_pressed)
	Language.connect("ReTranslate", self.reTranslate)
	reTranslate()


func on_newGameButton_pressed():
	Game.emit_signal("ChangeScene", "res://Playable/Playable.tscn", GameSettings.TRANSITIONS.FADE_SCREEN)


func on_optionsButton_pressed():
	# TODO
	print("Options")


func on_creditsButton_pressed():
	Game.emit_signal("ChangeScene", "res://Credits/Credits.tscn", GameSettings.TRANSITIONS.UP_BOTTOM)


func on_exitButton_pressed():
	Game.emit_signal("Exit")


func reTranslate():
	newGameButton.text = tr("NEW-GAME")
	optionsButton.text = tr("OPTIONS")
	creditsButton.text = tr("CREDITS")
	madeWithLabel.text = str(tr("MADE-WITH"), " Godot ", Engine.get_version_info().string)
	exitButton.text = tr("EXIT")
