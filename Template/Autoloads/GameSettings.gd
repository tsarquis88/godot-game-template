extends Node

enum TRANSITIONS { FADE_SCREEN, LEFT_RIGHT, UP_BOTTOM }
enum DIFFICULTY { EASY, NORMAL, HARD }

const CONFIG_FILE_PATH = "res://config.cfg"

var m_config
var m_game_difficulty
var m_music_volume
var m_sfx_volume


# Use of _init() in place of _ready() because the first is executed before
# This is needed because other autoloads use this node and it's not ready yet
func _init():
	m_config = ConfigFile.new()
	var err = m_config.load(CONFIG_FILE_PATH)
	if err != OK:
		print_debug(str("Error (", err, ") loading config file."))
	else:
		get_difficulty_from_filesystem()
		get_volumes_from_filesystem()


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


# Reads the volume scales from config file.
func get_volumes_from_filesystem():
	m_music_volume = get_setting("sound", "VOLUME-MUSIC")
	m_sfx_volume = get_setting("sound", "VOLUME-SFX")


# Changes the current music volume, storing its new value into the config file as well as in the
# current game execution.
func change_music_volume(new_volume):
	m_music_volume = new_volume
	set_setting("sound", "VOLUME-MUSIC", new_volume)


# Changes the current SFX volume, storing its new value into the config file as well as in the
# current game execution.
func change_sfx_volume(new_volume):
	m_sfx_volume = new_volume
	set_setting("sound", "VOLUME-SFX", new_volume)


# Music volume getter for other scenes.
func get_music_volume():
	return m_music_volume


# SFX volume getter for other scenes.
func get_sfx_volume():
	return m_sfx_volume
