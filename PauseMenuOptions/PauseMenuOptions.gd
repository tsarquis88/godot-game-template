extends Panel

signal Return

const SLIDER_SOUND = "volumeSlider.wav"
const BUTTON_SOUND = "button.wav"

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
	on_reTranslate()
	on_fullScreen(false)

	var styleBox = get_theme_stylebox("panel")
	styleBox.bg_color = Settings.MENU_BACKGROUND_COLOR
	styleBox.border_color = Settings.MENU_BORDER_COLOR

	Language.connect("ReTranslate", self.on_reTranslate)
	Resolution.connect("FullScreen", self.on_fullScreen)
	languageButton.connect("item_selected", self.on_languageButton_item_selected)
	fullScreenButton.connect("toggled", self.on_fullScreenButton_toggled)
	returnButton.connect("pressed", self.on_returnButton_pressed)
	returnButton.connect("pressed", self.on_button_pressed)
	volumeSlider.connect("value_changed", self.on_volumeSlider_value_changed)

	Logger.logDebug("PauseMenuOptions: Ready")


func on_reTranslate():
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
	volumeSlider.step = 0.0001
	volumeSlider.min_value = 0.0001
	volumeSlider.max_value = 1
	volumeSlider.value = 1


func on_fullScreenButton_toggled(fullScreen):
	Resolution.setFullScreen(fullScreen)


func on_returnButton_pressed():
	emit_signal("Return")


func on_button_pressed():
	SfxManager.playSfx(BUTTON_SOUND)


func on_volumeSlider_value_changed(newValue):
	SfxManager.setMasterVolumeDb(newValue)
	SfxManager.playSfx(SLIDER_SOUND)


func on_fullScreen(fullScreen):
	fullScreenButton.button_pressed = fullScreen
