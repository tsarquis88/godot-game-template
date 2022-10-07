extends Node2D


signal ChangeScene
signal FullScreen
signal Exit


@export var firstScene = "res://SplashScreen/SplashScreen.tscn"
@onready var transition = find_child("Transition")
@onready var nextScene = firstScene
@onready var currentSceneNode = null
@onready var fullScreenSize = DisplayServer.screen_get_size()
@onready var startScreenSize = DisplayServer.window_get_size()
@onready var scaleIncrement = Vector2()


# Offset due to an unappropiate scaling
const SCALE_INCREMENT_OFFSET = Vector2(0.065, 0.065)


func _ready()->void:
	connect("Exit", self.on_exit)
	connect("ChangeScene", self.on_changeScene)
	connect("FullScreen", self.on_fullScreen)
	transition.connect("Transition", self.instantiateCurrentScene)
	instantiateCurrentScene()
	scaleIncrement.x = float(startScreenSize.x) / float(fullScreenSize.x)
	scaleIncrement.y = float(startScreenSize.y) / float(fullScreenSize.y)
	scaleIncrement += SCALE_INCREMENT_OFFSET


func instantiateCurrentScene():
	if currentSceneNode != null:
		currentSceneNode.queue_free()
	
	currentSceneNode = load(nextScene).instantiate() 
	add_child(currentSceneNode)


func on_changeScene(newScene, transitionType)->void:
	match transitionType:
		GameSettings.TRANSITIONS.FADE_SCREEN:
			transition.fadeScreenTransition()
		GameSettings.TRANSITIONS.LEFT_RIGHT:
			transition.leftRightTransition()
		GameSettings.TRANSITIONS.UP_BOTTOM:
			transition.upBottomTransition()
	nextScene = newScene


func on_fullScreen(fullScreen):
	GameSettings.fullScreen = fullScreen
	if fullScreen:
		scale += scaleIncrement
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		scale -= scaleIncrement
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func on_exit()->void:
	get_tree().quit()

