extends Button

# Name of the button sound file.
const BUTTON_SOUND = "button.wav"


# Sets wrapper up.
func _ready():
	self.connect("pressed", on_pressed)


# Button pression handler.
func on_pressed():
	SfxManager.play_sfx(BUTTON_SOUND)
