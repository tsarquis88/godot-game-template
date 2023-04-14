extends Node2D

signal change_scene
signal exit

@export var m_first_scene = "res://Launch/Launch.tscn"
@onready var m_transition = find_child("Transition")
@onready var m_next_scene = m_first_scene
@onready var m_current_scene_node = null


func _ready() -> void:
	Logger.log_infor("Starting game")

	connect("exit", self.on_exit)
	connect("change_scene", self.on_change_scene)
	m_transition.connect("transition", self.instantiate_current_scene)
	instantiate_current_scene()

	Logger.log_debug("Game ready")


func instantiate_current_scene():
	if m_current_scene_node != null:
		m_current_scene_node.queue_free()

	m_current_scene_node = load(m_next_scene).instantiate()
	add_child(m_current_scene_node)

	Logger.log_debug(str("Changed to scene: ", m_current_scene_node.get_name()))


func on_change_scene(new_scene, transition_type) -> void:
	match transition_type:
		GameSettings.TRANSITIONS.FADE_SCREEN:
			m_transition.fade_screen_transition()
		GameSettings.TRANSITIONS.LEFT_RIGHT:
			m_transition.left_right_transition()
		GameSettings.TRANSITIONS.UP_BOTTOM:
			m_transition.up_bottom_transition()
	m_next_scene = new_scene


func on_exit() -> void:
	Logger.log_infor("Exiting game")

	get_tree().quit()
