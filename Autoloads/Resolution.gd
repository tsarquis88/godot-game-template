extends Node


signal ReScale


const DEFAULT_SCALE = Vector2(1, 1)


@onready var fullScreenSize = DisplayServer.screen_get_size()
@onready var startScreenSize = DisplayServer.window_get_size()
@onready var scaleIncrement = Vector2()


func _ready():
	scaleIncrement.x = float(fullScreenSize.x) / float(startScreenSize.x)
	scaleIncrement.y = float(fullScreenSize.y) / float(startScreenSize.y)


func setFullScreen(fullScreen):
	GameSettings.fullScreen = fullScreen
	if fullScreen:
		emit_signal("ReScale", scaleIncrement)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		emit_signal("ReScale", DEFAULT_SCALE)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
