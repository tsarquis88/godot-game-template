extends Node2D

@export var m_return_scene = "res://Template/MainMenu/MainMenu.tscn"
@onready var m_credits_label = find_child("CreditsLabel")
@onready var m_background = find_child("Background")
@onready var m_game = get_parent()


func _ready():
	m_background.color = Settings.MENU_BACKGROUND_COLOR
	m_credits_label.text = str(tr("CREDITS"), "\n\n")
	for credit_key in GameSettings.get_section_settings("credits"):
		m_credits_label.text += str(
			tr(credit_key),
			" ",
			tr("BY"),
			" ",
			GameSettings.get_setting("credits", credit_key),
			"\n"
		)

	Logger.log_debug("Credits: Ready")


func _input(event):
	if event is InputEventKey and event.pressed:
		m_game.emit_signal("change_scene", m_return_scene, GameSettings.TRANSITIONS.LEFT_RIGHT)
