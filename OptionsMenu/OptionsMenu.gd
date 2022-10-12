extends BoxContainer


signal FullScreen


const MAINMENU_SCENE = "res://MainMenu/MainMenu.tscn"
const ENGLISH_INDEX = 0
const SPANISH_INDEX = 1
const EASY_INDEX = 0
const NORMAL_INDEX = 1
const HARD_INDEX = 2
const SLIDER_SOUND = "volumeSlider.wav"
const BUTTON_SOUND = "button.wav"


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
	on_reTranslate()
	on_fullScreen(false)
	returnButton.connect("pressed", self.on_returnButton_pressed)
	languageButton.connect("item_selected", self.on_languageButton_item_selected)
	difficultyButton.connect("item_selected", self.on_difficultyButton_item_selected)
	fullScreenButton.connect("toggled", self.on_fullScreenButton_toggled)
	volumeSlider.connect("value_changed", self.on_volumeSlider_value_changed)
	volumeSlider.connect("drag_ended", self.on_volumeSlider_drag_ended)
	Language.connect("ReTranslate", self.on_reTranslate)
	Resolution.connect("FullScreen", self.on_fullScreen)


func on_returnButton_pressed():
	Game.emit_signal("ChangeScene", MAINMENU_SCENE, GameSettings.TRANSITIONS.UP_BOTTOM)
	SfxManager.playSfx(BUTTON_SOUND)


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
	Resolution.setFullScreen(fullScreen)


func on_volumeSlider_value_changed(_newValue):
	SfxManager.playSfx(SLIDER_SOUND)


func on_volumeSlider_drag_ended(valueChanged):
	if valueChanged:
		SfxManager.setMasterVolumeDb(volumeSlider.value)


func on_reTranslate():
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
	difficultyButton.select(NORMAL_INDEX)
	volumeSlider.step = 0.0001
	volumeSlider.min_value = 0.0001
	volumeSlider.max_value = 1
	volumeSlider.value = 1


func on_fullScreen(fullScreen):
	fullScreenButton.button_pressed = fullScreen
