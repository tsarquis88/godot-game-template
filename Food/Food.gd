extends Node2D

signal eaten
signal bad_position

@onready var m_timer = GlobalTimer.create_timeout(self.on_timeout, 0.5, true, false)


func _ready():
	self.connect("body_entered", self.on_body_entered)


func on_body_entered(body):
	if body.get_name() == "Snake":
		emit_signal("eaten")
	else:
		# This happens when the food is placed in the same position as a
		# Body or Tail
		emit_signal("bad_position")


# Highlight sprite.
func on_timeout():
	if modulate.a == 1:
		modulate.a = 0.75
	else:
		modulate.a = 1


func set_pause(pause: bool):
	if pause:
		GlobalTimer.stop_timeout(m_timer)
	else:
		GlobalTimer.start_timeout(m_timer)
