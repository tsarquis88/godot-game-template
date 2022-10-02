extends Node2D


signal ChangeScene
signal Exit


@export var firstScene = "Demo.tscn"
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


func on_ChangeScene(newScene)->void:
	# transition.fadeScreenTransition()
	# transition.leftRightTransition()
	transition.upBottomTransition()
	nextScene = newScene


func on_Exit()->void:
	get_tree().quit()

