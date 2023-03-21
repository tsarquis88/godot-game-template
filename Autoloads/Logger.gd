extends Node


const DEBUG_TAG = "[DEBUG]"
const INFOR_TAG	= "[INFOR]"
const ERROR_TAG = "[ERROR]"
const SEPARATOR = " "


enum {DEBUG_LEVEL, INFOR_LEVEL, ERROR_LEVEL}


var logLevel


# Use of _init() in place of _ready() because the first is executed before
# This is needed because other autoloads use this node and it's not ready yet
func _init():
	self.logLevel = DEBUG_LEVEL


func setLogLevel(logLevel : int):
	self.logLevel = logLevel


func log(tag : String, message : String, logLevel : int):
	if logLevel >= self.logLevel:
		print(tag, SEPARATOR, message)


func logDebug(message : String):
	self.log(DEBUG_TAG, message, DEBUG_LEVEL)


func logInfo(message : String):
	self.log(INFOR_TAG, message, INFOR_LEVEL)


func logError(message : String):
	self.log(ERROR_TAG, message, ERROR_LEVEL)
