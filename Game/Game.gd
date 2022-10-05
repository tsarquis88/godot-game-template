extends Node2D


signal ChangeScene
signal Exit


@export var firstScene = "res://SplashScreen/SplashScreen.tscn"
@onready var transition = find_child("Transition")
@onready var nextScene = firstScene
@onready var currentSceneNode = null


func _ready()->void:
	connect("Exit", self.on_Exit)
	connect("ChangeScene", self.on_ChangeScene)
	transition.connect("Transition", self.instantiateCurrentScene)
	instantiateCurrentScene()


func instantiateCurrentScene():
	if currentSceneNode != null:
		currentSceneNode.queue_free()
	
	currentSceneNode = load(nextScene).instantiate() 
	add_child(currentSceneNode)


func on_ChangeScene(newScene, transitionType)->void:
	match transitionType:
		GameSettings.TRANSITIONS.FADE_SCREEN:
			transition.fadeScreenTransition()
		GameSettings.TRANSITIONS.LEFT_RIGHT:
			transition.leftRightTransition()
		GameSettings.TRANSITIONS.UP_BOTTOM:
			transition.upBottomTransition()
	nextScene = newScene


func on_Exit()->void:
	get_tree().quit()

