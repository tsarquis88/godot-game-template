extends Node2D


signal ChangeScene
signal Exit


@export var firstScene = "res://SplashScreen/SplashScreen.tscn"
@onready var transition = find_child("Transition")
@onready var nextScene = firstScene
@onready var currentSceneNode = null


func _ready()->void:
	Logger.logInfo("Starting game")
	
	connect("Exit", self.on_exit)
	connect("ChangeScene", self.on_changeScene)
	transition.connect("Transition", self.instantiateCurrentScene)
	instantiateCurrentScene()
	
	Logger.logDebug("Game ready")


func instantiateCurrentScene():
	if currentSceneNode != null:
		currentSceneNode.queue_free()
	
	currentSceneNode = load(nextScene).instantiate() 
	add_child(currentSceneNode)
	
	Logger.logDebug(str("Changed to scene: ", currentSceneNode.get_name()))


func on_changeScene(newScene, transitionType)->void:
	match transitionType:
		GameSettings.TRANSITIONS.FADE_SCREEN:
			transition.fadeScreenTransition()
		GameSettings.TRANSITIONS.LEFT_RIGHT:
			transition.leftRightTransition()
		GameSettings.TRANSITIONS.UP_BOTTOM:
			transition.upBottomTransition()
	nextScene = newScene


func on_exit()->void:
	Logger.logInfo("Exiting game")
	
	get_tree().quit()
