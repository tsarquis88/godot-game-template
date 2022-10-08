extends Panel


signal FullScreen
signal Return


const ENGLISH_INDEX = 0
const SPANISH_INDEX = 1


@onready var returnButton = find_child("ReturnButton")
@onready var languageButton = find_child("LanguageButton")
@onready var fullScreenButton = find_child("FullScreenButton")
@onready var volumeSlider = find_child("VolumeSlider")
@onready var languageLabel = find_child("LanguageLabel")
@onready var fullScreenLabel = find_child("FullScreenLabel")
@onready var volumeLabel = find_child("VolumeLabel")
@onready var title = find_child("Title")


func _ready():
	Language.connect("ReTranslate", self.reTranslate)
	languageButton.connect("item_selected", self.on_languageButton_item_selected)
	fullScreenButton.connect("toggled", self.on_fullScreenButton_toggled)
	volumeSlider.connect("value_changed", self.on_volumeSlider_value_changed)
	returnButton.connect("pressed", self.on_returnButton_pressed)
	setDefaulValues()
	reTranslate()


func reTranslate():
	returnButton.text = tr("RETURN")
	languageLabel.text = tr("LANGUAGE")
	fullScreenLabel.text = tr("FULL-SCREEN")
	volumeLabel.text = tr("VOLUME")
	title.text = tr("OPTIONS")


func on_languageButton_item_selected(index):
	match index:
		ENGLISH_INDEX:
			Language.set_language("en")
		SPANISH_INDEX:
			Language.set_language("es")


func setDefaulValues():	
	if Language.get_language() == "es":
		languageButton.select(SPANISH_INDEX)
	else:
		languageButton.select(ENGLISH_INDEX)
	
	fullScreenButton.button_pressed = GameSettings.fullScreen


func on_fullScreenButton_toggled(fullScreen):
	emit_signal("FullScreen", fullScreen)


func on_returnButton_pressed():
	emit_signal("Return")


func on_volumeSlider_value_changed(_newValue):
	# TODO: Sound manager autoload
	pass
