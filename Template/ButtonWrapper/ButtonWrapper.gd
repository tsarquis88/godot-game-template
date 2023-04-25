extends Button

@onready var m_button_sound = load("res://Template/Assets/SFX/button.wav")


# Sets wrapper up.
func _ready():
	self.connect("pressed", on_pressed)


# Button pression handler.
func on_pressed():
	SfxManager.play_sfx(m_button_sound)
