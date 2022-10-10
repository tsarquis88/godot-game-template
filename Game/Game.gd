extends Node2D


signal ChangeScene
signal Exit


@export var firstScene = "res://SplashScreen/SplashScreen.tscn"
@onready var transition = find_child("Transition")
@onready var nextScene = firstScene
@onready var currentSceneNode = null


func _ready()->void:
	connect("Exit", self.on_exit)
	connect("ChangeScene", self.on_changeScene)
	transition.connect("Transition", self.instantiateCurrentScene)
	Resolution.connect("ReScale", self.on_resolution_reScale)
	instantiateCurrentScene()


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


func on_exit()->void:
	get_tree().quit()


func on_resolution_reScale(newScale):
	self.scale = newScale
