extends Node2D


# Signal emitted when game finishes. It should be accompanied with a boolean
# indicating if the player won (true) or lost (false).
signal End


@onready var m_player = find_child("Player")
@onready var m_target = find_child("Target")


func _ready():
	m_target.connect("body_entered", on_targetBodyEntered)


func on_targetBodyEntered(_body):
	emit_signal("End", true)


# Method used by the Playground node in order to set the pause. This method
# should be always implemented and it should take care of the pause mode of its
# children nodes.
func setPause(pause : bool):
	m_player.setPause(pause)
	m_target.setPause(pause)
