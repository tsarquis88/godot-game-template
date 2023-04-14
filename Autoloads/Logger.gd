extends Node


# Log headers
const DEBUG_TAG = "[DEBUG]"
const INFOR_TAG	= "[INFOR]"
const ERROR_TAG = "[ERROR]"
const SEPARATOR = " "


# Log levels allowed
enum {DEBUG_LEVEL, INFOR_LEVEL, ERROR_LEVEL}


# Current log level
var m_logLevel


# Use of _init() in place of _ready() because the first is executed before
# This is needed because other autoloads use this node and it's not ready yet
func _init():
	m_logLevel = DEBUG_LEVEL


# Log level setter
func setLogLevel(logLevel : int):
	m_logLevel = logLevel


# Method in charge of printing a message into the stdout
func logMessage(tag : String, message : String, logLevel : int):
	if logLevel >= m_logLevel:
		print(tag, SEPARATOR, message)


# Wrapper for logMessage() with DEBUG level
func logDebug(message : String):
	logMessage(DEBUG_TAG, message, DEBUG_LEVEL)


# Wrapper for logMessage() with INFOR level
func logInfor(message : String):
	logMessage(INFOR_TAG, message, INFOR_LEVEL)


# Wrapper for logMessage() with ERROR level
func logError(message : String):
	logMessage(ERROR_TAG, message, ERROR_LEVEL)
