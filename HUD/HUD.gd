extends CanvasLayer

@onready var m_text_label = find_child("TextLabel")
@onready var m_time_label = find_child("TimeLabel")
@onready var m_hurry_up_label = find_child("HurryUpLabel")
@onready var m_second_timer = GlobalTimer.create_timeout(on_timeout, 1.0, true, false)
@onready var m_hurry_timer = GlobalTimer.create_timeout(on_timeout_hurry_toggle, 0.5, false, false)
@onready var m_seconds = 0


# Sets up the HUD
func _ready():
	Language.connect("re_translate", self.on_re_translate)
	m_time_label.text = "0"
	m_hurry_up_label.visible = false
	on_re_translate()


# Updates the time label
func on_timeout():
	m_seconds += 1
	m_time_label.text = str(m_seconds)
	if m_seconds == 10:
		GlobalTimer.start_timeout(m_hurry_timer)


# Toggles hurry-up label visibility
func on_timeout_hurry_toggle():
	m_hurry_up_label.visible = not m_hurry_up_label.visible


# Update labels text
func on_re_translate():
	m_text_label.text = tr("HUD-TIME")
	m_hurry_up_label.text = tr("HUD-HURRY-UP")


# Method used by the Playground node in order to set the pause. This method
# should be always implemented and it should take care of the pause mode of its
# children nodes.
func set_pause(pause: bool):
	if pause:
		GlobalTimer.stop_timeout(m_second_timer)
		GlobalTimer.stop_timeout(m_hurry_timer)
	else:
		GlobalTimer.start_timeout(m_second_timer)
		if m_seconds >= 10:
			GlobalTimer.start_timeout(m_hurry_timer)
