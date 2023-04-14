extends Node2D

signal transition

# This could be parametrized in init()
const START_DURATION = 0.6
const END_DURATION = 0.6
const WAIT_DURATION = 0.3

var m_property
var m_start_final_value
var m_end_final_value

@onready var m_black_background = find_child("BlackBG")


func fade_screen_transition():
	m_black_background.modulate.a = 0
	m_black_background.size.x = DisplayServer.screen_get_size().x
	m_black_background.size.y = DisplayServer.screen_get_size().y
	m_property = "modulate:a"
	m_start_final_value = 1
	m_end_final_value = 0
	start_transition()


func left_right_transition():
	m_black_background.modulate.a = 1
	m_black_background.size.x = 0
	m_black_background.size.y = DisplayServer.screen_get_size().y
	m_property = "size:x"
	m_start_final_value = DisplayServer.screen_get_size().x
	m_end_final_value = 0
	start_transition()


func up_bottom_transition():
	m_black_background.modulate.a = 1
	m_black_background.size.x = DisplayServer.screen_get_size().x
	m_black_background.size.y = 0
	m_property = "size:y"
	m_start_final_value = DisplayServer.screen_get_size().y
	m_end_final_value = 0
	start_transition()


func start_transition():
	start_tween(m_start_final_value, START_DURATION, self.wait)


func end_transition():
	start_tween(m_end_final_value, END_DURATION, self.end)


func start_tween(final_value, duration, callback):
	var tween = create_tween()
	tween.tween_property(m_black_background, m_property, final_value, duration)
	tween.tween_callback(callback)


func wait():
	emit_signal("transition")
	GlobalTimer.create_timeout(self.end_transition, WAIT_DURATION)


func end():
	pass
