extends Node2D

signal clock
signal end
signal hud_update_food

var m_clock_timer

@onready var m_food_eaten_sound = load("res://Assets/SFX/food_eaten.wav")
@onready var m_snake_dead_sound = load("res://Assets/SFX/snake_dead.wav")
@onready var m_window_size = DisplayServer.window_get_size()
@onready var m_food = find_child("Food")
@onready var m_snake = find_child("Snake")
@onready var m_pause = false


func _ready():
	m_food.connect("eaten", on_food_eaten)
	m_food.connect("bad_position", on_food_bad_position)
	m_snake.connect("dead", on_snake_dead)

	var clock_duration
	match GameSettings.get_setting("game", "DIFFICULTY"):
		GameSettings.DIFFICULTY.EASY:
			clock_duration = 0.2
		GameSettings.DIFFICULTY.NORMAL:
			clock_duration = 0.1
		GameSettings.DIFFICULTY.HARD:
			clock_duration = 0.05

	m_clock_timer = GlobalTimer.create_timeout(self.on_clock, clock_duration, true, false)


func on_food_eaten():
	reset_food_position()
	m_snake.feed()
	emit_signal("hud_update_food", m_snake.get_size())
	SfxManager.play_sfx(m_food_eaten_sound)


func on_snake_dead():
	emit_signal("end", false, m_snake.get_size())
	SfxManager.play_sfx(m_snake_dead_sound)


func on_clock():
	emit_signal("clock")


func set_pause(new_pause):
	m_pause = new_pause
	m_food.set_pause(new_pause)

	if m_pause:
		GlobalTimer.stop_timeout(m_clock_timer)
	else:
		GlobalTimer.start_timeout(m_clock_timer)


func on_food_bad_position():
	reset_food_position()


func reset_food_position():
	while true:
		var random_position = Vector2(m_window_size.x * randf(), m_window_size.y * randf())
		if (
			random_position.y + 16 < m_window_size.y
			and random_position.y - 16 > 0
			and random_position.x + 16 < m_window_size.x
			and random_position.x - 16 > 0
		):
			m_food.set_position(random_position)
			break
