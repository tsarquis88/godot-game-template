extends Panel


signal FullScreen
signal Return


const SLIDER_SOUND_FILE = "volumeSlider.wav"
const BUTTON_SOUND_FILE = "button.wav"


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
	setDefaulValues()
	reTranslate()
	Language.connect("ReTranslate", self.reTranslate)
	languageButton.connect("item_selected", self.on_languageButton_item_selected)
	fullScreenButton.connect("toggled", self.on_fullScreenButton_toggled)
	returnButton.connect("pressed", self.on_returnButton_pressed)
	returnButton.connect("pressed", self.on_button_pressed)
	volumeSlider.connect("value_changed", self.on_volumeSlider_value_changed)


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
	volumeSlider.step = 0.0001
	volumeSlider.min_value = 0.0001
	volumeSlider.max_value = 1
	volumeSlider.value = 1


func on_fullScreenButton_toggled(fullScreen):
	emit_signal("FullScreen", fullScreen)


func on_returnButton_pressed():
	emit_signal("Return")


func on_button_pressed():
	SfxManager.play(BUTTON_SOUND_FILE)


func on_volumeSlider_value_changed(newValue):
	SfxManager.setMasterVolumeDb(newValue)
	SfxManager.play(SLIDER_SOUND_FILE)
