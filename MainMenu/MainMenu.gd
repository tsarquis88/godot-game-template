extends BoxContainer


@onready var newGameButton = find_child("NewGameButton")
@onready var optionsButton = find_child("OptionsButton")
@onready var creditsButton = find_child("CreditsButton")
@onready var exitButton = find_child("ExitButton")
@onready var Game = get_parent()


func _ready():
	# TODO: add retranslate mechanics
	
	newGameButton.connect("pressed", self.on_newGameButton_pressed)
	optionsButton.connect("pressed", self.on_optionsButton_pressed)
	creditsButton.connect("pressed", self.on_creditsButton_pressed)
	exitButton.connect("pressed", self.on_exitButton_pressed)


func on_newGameButton_pressed():
	# TODO
	print("New Game")


func on_optionsButton_pressed():
	# TODO
	print("Options")


func on_creditsButton_pressed():
	# TODO
	print("Credits")


func on_exitButton_pressed():
	# TODO
	print("Exit")
