extends BoxContainer


const MAINMENU_SCENE = "res://MainMenu/MainMenu.tscn"
const ENGLISH_INDEX = 0
const SPANISH_INDEX = 1
const EASY_INDEX = 0
const NORMAL_INDEX = 1
const HARD_INDEX = 2


@onready var returnButton = find_child("ReturnButton")
@onready var languageButton = find_child("LanguageButton")
@onready var difficultyButton = find_child("DifficultyButton")
@onready var languageLabel = find_child("LanguageLabel")
@onready var difficultyLabel = find_child("DifficultyLabel")
@onready var Game = get_parent()


# TODO: Default settings in option menus


func _ready():
	returnButton.connect("pressed", self.on_returnButton_pressed)
	languageButton.connect("item_selected", self.on_languageButton_item_selected)
	Language.connect("ReTranslate", self.reTranslate)
	reTranslate()


func on_returnButton_pressed():
	Game.emit_signal("ChangeScene", MAINMENU_SCENE, GameSettings.TRANSITIONS.UP_BOTTOM)


func on_languageButton_item_selected(index):
	match index:
		ENGLISH_INDEX:
			Language.set_language("en")
		SPANISH_INDEX:
			Language.set_language("es")


func reTranslate():
	difficultyButton.set_item_text(EASY_INDEX, tr("EASY"))
	difficultyButton.set_item_text(NORMAL_INDEX, tr("NORMAL"))
	difficultyButton.set_item_text(HARD_INDEX, tr("HARD"))
	returnButton.text = tr("RETURN")
	languageLabel.text = tr("LANGUAGE")
	difficultyLabel.text = tr("DIFFICULTY")
