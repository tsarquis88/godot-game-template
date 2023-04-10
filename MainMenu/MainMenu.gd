extends BoxContainer


const PLAYABLE_SCENE = "res://Playable/Playable.tscn"
const CREDITS_SCENE = "res://Credits/Credits.tscn"
const OPTIONS_SCENE = "res://OptionsMenu/OptionsMenu.tscn"
const BUTTON_SOUND = "button.wav"

@onready var background = find_child("Background")
@onready var newGameButton = find_child("NewGameButton")
@onready var optionsButton = find_child("OptionsButton")
@onready var creditsButton = find_child("CreditsButton")
@onready var exitButton = find_child("ExitButton")
@onready var madeWithLabel = find_child("MadeWithLabel")
@onready var Game = get_parent()


func _ready():
	background.color = Settings.MENU_BACKGROUND_COLOR
	newGameButton.connect("pressed", self.on_newGameButton_pressed)
	optionsButton.connect("pressed", self.on_optionsButton_pressed)
	creditsButton.connect("pressed", self.on_creditsButton_pressed)
	exitButton.connect("pressed", self.on_exitButton_pressed)
	newGameButton.connect("pressed", self.on_button_pressed)
	optionsButton.connect("pressed", self.on_button_pressed)
	creditsButton.connect("pressed", self.on_button_pressed)
	exitButton.connect("pressed", self.on_button_pressed)
	Language.connect("ReTranslate", self.reTranslate)
	reTranslate()
	
	Logger.logDebug("MainMenu: Ready")


func on_newGameButton_pressed():
	Game.emit_signal("ChangeScene", PLAYABLE_SCENE, GameSettings.TRANSITIONS.FADE_SCREEN)


func on_optionsButton_pressed():
	Game.emit_signal("ChangeScene", OPTIONS_SCENE, GameSettings.TRANSITIONS.LEFT_RIGHT)


func on_creditsButton_pressed():
	Game.emit_signal("ChangeScene", CREDITS_SCENE, GameSettings.TRANSITIONS.UP_BOTTOM)


func on_exitButton_pressed():
	Game.emit_signal("Exit")


func on_button_pressed():
	SfxManager.playSfx(BUTTON_SOUND)


func reTranslate():
	newGameButton.text = tr("NEW-GAME")
	optionsButton.text = tr("OPTIONS")
	creditsButton.text = tr("CREDITS")
	madeWithLabel.text = str(tr("MADE-WITH"), " Godot ", Engine.get_version_info().string)
	exitButton.text = tr("EXIT")
