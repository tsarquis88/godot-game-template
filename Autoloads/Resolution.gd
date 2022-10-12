extends Node


signal FullScreen


const DEFAULT_SCALE = Vector2(1, 1)


@onready var isFullScreen = false
@onready var blockSizeChanged = false

func _ready():
	get_tree().get_root().connect("size_changed", self.on_size_changed)


func setFullScreen(fullScreen):
	isFullScreen = fullScreen
	blockSizeChanged = true
	if fullScreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	emit_signal("FullScreen", isFullScreen)
	GlobalTimer.create_timeout(self.unBlockSizeChanged, 0.5)


func unBlockSizeChanged():
	blockSizeChanged = false


func on_size_changed():
	if blockSizeChanged:
		return
	setFullScreen(not isFullScreen)
