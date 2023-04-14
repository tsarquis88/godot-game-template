extends Node2D

@export var m_next_scene = "res://Template/MainMenu/MainMenu.tscn"
@export var m_duration = 3
@onready var m_won_label = find_child("WonLabel")
@onready var m_background = find_child("Background")
@onready var m_game = get_parent()
@onready var m_timer = GlobalTimer.create_timeout(self.finish, m_duration, true, true)


func _ready():
	m_background.color = Settings.MENU_BACKGROUND_COLOR
	m_won_label.text = tr("WON-MESSAGE")

	Logger.log_debug("WonScreen: Ready")


func finish():
	GlobalTimer.delete_timeout(m_timer)
	m_game.emit_signal("change_scene", m_next_scene, GameSettings.TRANSITIONS.UP_BOTTOM)
