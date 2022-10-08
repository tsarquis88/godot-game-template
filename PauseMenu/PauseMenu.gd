extends Panel


signal ExitGame
signal Options
signal Resume


@onready var exitButton = find_child("ExitButton")
@onready var optionsButton = find_child("OptionsButton")
@onready var resumeButton = find_child("ResumeButton")
@onready var title = find_child("Title")


func _ready():
	exitButton.connect("pressed", self.on_exitButton_pressed)
	optionsButton.connect("pressed", self.on_optionsButton_pressed)
	resumeButton.connect("pressed", self.on_resumeButton_pressed)
	Language.connect("ReTranslate", self.reTranslate)
	reTranslate()


func on_exitButton_pressed():
	emit_signal("ExitGame")


func on_optionsButton_pressed():
	emit_signal("Options")


func on_resumeButton_pressed():
	emit_signal("Resume")


func reTranslate():
	exitButton.text = tr("EXIT")
	optionsButton.text = tr("OPTIONS")
	resumeButton.text = tr("RESUME")
	title.text = tr("GAME-PAUSED")
