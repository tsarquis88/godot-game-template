extends BoxContainer


const MAINMENU_SCENE = "res://MainMenu/MainMenu.tscn"
const ENGLISH_INDEX = 0
const SPANISH_INDEX = 1
const EASY_INDEX = 0
const NORMAL_INDEX = 1
const HARD_INDEX = 2


@onready var background = find_child("Background")
@onready var returnButton = find_child("ReturnButton")
@onready var languageButton = find_child("LanguageButton")
@onready var difficultyButton = find_child("DifficultyButton")
@onready var fullScreenButton = find_child("FullScreenButton")
@onready var volumeSlider = find_child("VolumeSlider")
@onready var languageLabel = find_child("LanguageLabel")
@onready var difficultyLabel = find_child("DifficultyLabel")
@onready var fullScreenLabel = find_child("FullScreenLabel")
@onready var volumeLabel = find_child("VolumeLabel")
@onready var Game = get_parent()


func _ready():
	setDefaulValues()
	reTranslate()
	returnButton.connect("pressed", self.on_returnButton_pressed)
	languageButton.connect("item_selected", self.on_languageButton_item_selected)
	difficultyButton.connect("item_selected", self.on_difficultyButton_item_selected)
	fullScreenButton.connect("toggled", self.on_fullScreenButton_toggled)
	volumeSlider.connect("value_changed", self.on_volumeSlider_value_changed)
	Language.connect("ReTranslate", self.reTranslate)


func on_returnButton_pressed():
	Game.emit_signal("ChangeScene", MAINMENU_SCENE, GameSettings.TRANSITIONS.UP_BOTTOM)


func on_languageButton_item_selected(index):
	match index:
		ENGLISH_INDEX:
			Language.set_language("en")
		SPANISH_INDEX:
			Language.set_language("es")


func on_difficultyButton_item_selected(index):
	match index:
		EASY_INDEX:
			GameSettings.gameDifficulty = GameSettings.DIFFICULTY.EASY
		NORMAL_INDEX:
			GameSettings.gameDifficulty = GameSettings.DIFFICULTY.NORMAL
		HARD_INDEX:
			GameSettings.gameDifficulty = GameSettings.DIFFICULTY.HARD


func on_fullScreenButton_toggled(fullScreen):
	Game.emit_signal("FullScreen", fullScreen)


func on_volumeSlider_value_changed(newValue):
	# TODO: Sound manager autoload
	pass


func reTranslate():
	difficultyButton.set_item_text(EASY_INDEX, tr("EASY"))
	difficultyButton.set_item_text(NORMAL_INDEX, tr("NORMAL"))
	difficultyButton.set_item_text(HARD_INDEX, tr("HARD"))	
	returnButton.text = tr("RETURN")
	languageLabel.text = tr("LANGUAGE")
	difficultyLabel.text = tr("DIFFICULTY")
	fullScreenLabel.text = tr("FULL-SCREEN")
	volumeLabel.text = tr("VOLUME")

func setDefaulValues():	
	if Language.get_language() == "es":
		languageButton.select(SPANISH_INDEX)
	else:
		languageButton.select(ENGLISH_INDEX)
	
	fullScreenButton.button_pressed = GameSettings.fullScreen
	difficultyButton.select(NORMAL_INDEX)
	

