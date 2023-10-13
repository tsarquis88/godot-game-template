extends Node

enum TRANSITIONS { FADE_SCREEN, LEFT_RIGHT, UP_BOTTOM }
enum DIFFICULTY { EASY, NORMAL, HARD }

const CONFIG_FILE_PATH = "res://config.cfg"

var m_config_map


# Load setting from the config file.
# _init() is needed in place of _ready() because other nodes need this autload.
func _init():
	print("Loading configs from filesystem")
	load_settings_from_filesystem()


# Load configs from the config file and store them in memory. This is intended
# to be called just at the beginning of the execution.
func load_settings_from_filesystem() -> void:
	var config_file = load_config_file()
	m_config_map = Dictionary()
	for section in config_file.get_sections():
		m_config_map[section] = Dictionary()
		for key in config_file.get_section_keys(section):
			m_config_map[section][key] = config_file.get_value(section, key)


# Read config file.
func load_config_file() -> ConfigFile:
	var config = ConfigFile.new()
	var err = config.load(CONFIG_FILE_PATH)
	if err != OK:
		print_debug(str("Error (", err, ") loading config file."))
		return null
	return config


# Dump configs into the config file. This is intended to be called just once
# at the end of the execution.
func write_settings_into_filesystem() -> int:
	var config_file = load_config_file()
	for section in m_config_map.keys():
		for key in m_config_map.get(section).keys():
			config_file.set_value(section, key, m_config_map.get(section).get(key))
	return save_config_file(config_file)


# Save config file.
func save_config_file(config_file: ConfigFile) -> int:
	var err = config_file.save(CONFIG_FILE_PATH)
	if err != OK:
		print_debug(str("Error (", err, ") writing into config file."))
		return FAILED
	return OK


# Get config value, given a section and a key.
func get_setting(section: String, key: String) -> Variant:
	var section_settings = get_section_settings(section)
	if section_settings != null:
		if section_settings.has(key):
			return section_settings.get(key)
		print_debug(str("No such key: ", key))
	return null


# Get section configs.
func get_section_settings(section: String) -> Dictionary:
	if m_config_map.has(section):
		return m_config_map.get(section)
	print_debug(str("No such section: ", section))
	return Dictionary()


# Set setting, given a section, a key, and a new value.
func set_setting(section: String, key: String, value: Variant) -> void:
	m_config_map[section][key] = value


# Used to handle the close request notification.
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Logger.log_infor("Writting configs into filesystem")
		write_settings_into_filesystem()
