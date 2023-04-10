extends Panel


signal ExitGame
signal Options
signal Resume


const BUTTON_SOUND = "button.wav"


@onready var exitButton = find_child("ExitButton")
@onready var optionsButton = find_child("OptionsButton")
@onready var resumeButton = find_child("ResumeButton")
@onready var title = find_child("Title")


func _ready():
	var styleBox = get_theme_stylebox("panel")
	styleBox.bg_color = Settings.MENU_BACKGROUND_COLOR
	styleBox.border_color = Settings.MENU_BORDER_COLOR
	
	exitButton.connect("pressed", self.on_exitButton_pressed)
	optionsButton.connect("pressed", self.on_optionsButton_pressed)
	resumeButton.connect("pressed", self.on_resumeButton_pressed)
	exitButton.connect("pressed", self.on_button_pressed)
	optionsButton.connect("pressed", self.on_button_pressed)
	resumeButton.connect("pressed", self.on_button_pressed)
	Language.connect("ReTranslate", self.reTranslate)
	reTranslate()
	
	Logger.logDebug("PauseMenu: Ready")


func on_exitButton_pressed():
	emit_signal("ExitGame")


func on_optionsButton_pressed():
	emit_signal("Options")


func on_resumeButton_pressed():
	emit_signal("Resume")


func on_button_pressed():
	SfxManager.playSfx(BUTTON_SOUND)


func reTranslate():
	exitButton.text = tr("EXIT")
	optionsButton.text = tr("OPTIONS")
	resumeButton.text = tr("RESUME")
	title.text = tr("GAME-PAUSED")
