extends HSlider

@onready var m_slider_sound = load("res://Template/Assets/SFX/volumeSlider.wav")


# Sets wrapper up.
func _ready():
	self.connect("value_changed", on_value_changed)


# Configures the slider.
func configure_slider(
	new_step: float, new_min_value: float, new_max_value: float, new_value: float
):
	self.disconnect("value_changed", on_value_changed)
	self.step = new_step
	self.min_value = new_min_value
	self.max_value = new_max_value
	self.value = new_value
	self.connect("value_changed", on_value_changed)


# Slider value changed handler.
func on_value_changed(_new_value):
	SfxManager.play_sfx(m_slider_sound)
