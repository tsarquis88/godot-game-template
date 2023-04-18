extends Node2D

# Signal emitted when game finishes. It should be accompanied with a boolean
# indicating if the player won (true) or lost (false).
signal end

@onready var m_player = find_child("Player")
@onready var m_target = find_child("Target")
@onready var m_end_timer = GlobalTimer.create_timeout(on_timeout, 15, true, false)


func _ready():
	m_target.connect("body_entered", on_target_body_entered)


func on_target_body_entered(_body):
	emit_signal("end", true)


func on_timeout():
	emit_signal("end", false)


# Method used by the Playground node in order to set the pause. This method
# should be always implemented and it should take care of the pause mode of its
# children nodes.
func set_pause(pause: bool):
	m_player.set_pause(pause)
	m_target.set_pause(pause)
	if pause:
		GlobalTimer.stop_timeout(m_end_timer)
	else:
		GlobalTimer.start_timeout(m_end_timer)
