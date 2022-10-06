extends BoxContainer


const MAINMENU_SCENE = "res://MainMenu/MainMenu.tscn"
const ENGLISH_INDEX = 0
const SPANISH_INDEX = 1

@onready var returnButton = find_child("ReturnButton")
@onready var languageButton = find_child("LanguageButton")
@onready var Game = get_parent()


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
	returnButton.text = tr("RETURN")
