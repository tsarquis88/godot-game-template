extends Node

# Log levels allowed
enum { DEBUG_LEVEL, INFOR_LEVEL, ERROR_LEVEL }

# Log headers
const DEBUG_TAG = "[DEBUG]"
const INFOR_TAG = "[INFOR]"
const ERROR_TAG = "[ERROR]"
const SEPARATOR = " "

# Current log level
var m_log_level


# Use of _init() in place of _ready() because the first is executed before
# This is needed because other autoloads use this node and it's not ready yet
func _init():
	m_log_level = DEBUG_LEVEL


# Log level setter
func set_log_level(log_level: int):
	m_log_level = log_level


# Method in charge of printing a message into the stdout
func _log(tag: String, message: String, log_level: int):
	if log_level >= m_log_level:
		print(tag, SEPARATOR, message)


# Wrapper for _log() with DEBUG level
func log_debug(message: String):
	_log(DEBUG_TAG, message, DEBUG_LEVEL)


# Wrapper for _log() with INFOR level
func log_infor(message: String):
	_log(INFOR_TAG, message, INFOR_LEVEL)


# Wrapper for _log() with ERROR level
func log_error(message: String):
	_log(ERROR_TAG, message, ERROR_LEVEL)
