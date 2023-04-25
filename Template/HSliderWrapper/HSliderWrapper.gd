extends HSlider

@onready var m_slider_sound = load("res://Template/Assets/SFX/volumeSlider.wav")


# Sets wrapper up.
func _ready():
	self.connect("value_changed", on_value_changed)


# Configures the slider.
func configure_slider(step: float, min_value: float, max_value: float, value: float):
	self.disconnect("value_changed", on_value_changed)
	self.step = step
	self.min_value = min_value
	self.max_value = max_value
	self.value = value
	self.connect("value_changed", on_value_changed)


# Slider value changed handler.
func on_value_changed(_new_value):
	SfxManager.play_sfx(m_slider_sound)
