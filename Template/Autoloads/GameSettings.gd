extends Node

enum TRANSITIONS { FADE_SCREEN, LEFT_RIGHT, UP_BOTTOM }
enum DIFFICULTY { EASY, NORMAL, HARD }

const CONFIG_FILE_PATH = "res://config.cfg"

var m_config
var m_game_difficulty
var m_volume


# Use of _init() in place of _ready() because the first is executed before
# This is needed because other autoloads use this node and it's not ready yet
func _init():
	m_config = ConfigFile.new()
	var err = m_config.load(CONFIG_FILE_PATH)
	if err != OK:
		print_debug(str("Error (", err, ") loading config file."))
	else:
		get_difficulty_from_filesystem()
		get_volume_from_filesystem()


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


# Reads the difficulty level from config file.
func get_difficulty_from_filesystem():
	m_game_difficulty = get_setting("game", "DIFFICULTY")


# Changes the current difficulty, storing its new value into the config file as well as in the
# current game execution.
func change_difficulty(new_difficulty: int):
	m_game_difficulty = new_difficulty
	set_setting("game", "DIFFICULTY", new_difficulty)


# Difficulty getter for other scenes.
func get_difficulty():
	return m_game_difficulty


# Reads the volume scale from config file.
func get_volume_from_filesystem():
	m_volume = get_setting("sound", "VOLUME")


# Changes the current volume, storing its new value into the config file as well as in the
# current game execution.
func change_volume(new_volume: float):
	m_volume = new_volume
	set_setting("sound", "VOLUME", new_volume)


# Volume getter for other scenes.
func get_volume():
	return m_volume
