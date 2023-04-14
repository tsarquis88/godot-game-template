extends Node

enum TRANSITIONS { FADE_SCREEN, LEFT_RIGHT, UP_BOTTOM }
enum DIFFICULTY { EASY, NORMAL, HARD }

const CONFIG_FILE_PATH = "res://config.cfg"

var m_config

@onready var m_game_difficulty = DIFFICULTY.NORMAL


# Use of _init() in place of _ready() because the first is executed before
# This is needed because other autoloads use this node and it's not ready yet
func _init():
	m_config = ConfigFile.new()
	var err = m_config.load(CONFIG_FILE_PATH)
	if err != OK:
		print_debug(str("Error (", err, ") loading config file."))


func get_setting(section, key):
	if m_config.has_section_key(section, key):
		return m_config.get_value(section, key)
	print_debug(str("Non existant section/key (", section, ": ", key, ") in config file."))
	return null


func set_setting(section, key, new_value):
	m_config.set_value(section, key, new_value)
	var err = m_config.save(CONFIG_FILE_PATH)
	if err != OK:
		print_debug(str("Error (", err, ") writing into config file."))


func get_section_keys(section):
	if m_config.has_section(section):
		return m_config.get_section_keys(section)
	print_debug(str("Non existant section (", section, ") in config file."))
	return null
