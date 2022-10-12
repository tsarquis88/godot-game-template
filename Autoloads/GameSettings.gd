extends Node


enum TRANSITIONS {FADE_SCREEN, LEFT_RIGHT, UP_BOTTOM}
enum DIFFICULTY {EASY, NORMAL, HARD}


const CONFIG_FILE_PATH = "res://config.cfg"


@onready var gameDifficulty = DIFFICULTY.NORMAL


var config


# Use of _init() in place of _ready() because the first is executed before
# This is needed because other autoloads use this node and it's not ready yet
func _init():
	config = ConfigFile.new()
	var err = config.load(CONFIG_FILE_PATH)
	if err != OK:
		print_debug(str("Error (", err, ") loading config file."))


func getSetting(section, key):
	if config.has_section_key(section, key):
		return config.get_value(section, key)
	else:
		print_debug(str("Non existant section/key (", section, ": ", key, ") in config file."))
		return null


func setSetting(section, key, newValue):
	config.set_value(section, key, newValue)
	var err = config.save(CONFIG_FILE_PATH)
	if err != OK:
		print_debug(str("Error (", err, ") writing into config file."))


func getSectionKeys(section):
	if config.has_section(section):
		return config.get_section_keys(section)
	else:
		print_debug(str("Non existant section (", section, ") in config file."))
		return null
