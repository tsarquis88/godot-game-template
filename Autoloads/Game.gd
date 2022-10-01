extends Node2D


signal ChangeScene
signal Exit


@export var firstScene = "Demo.tscn"
@onready var fadeScreen = find_child("FadeScreen")
@onready var nextScene = firstScene
@onready var currentSceneNode = null


func _ready()->void:
	connect("Exit", self.on_Exit)
	connect("ChangeScene", self.on_ChangeScene)
	fadeScreen.connect("Waiting", self.instantiateCurrentScene)
	instantiateCurrentScene()


func instantiateCurrentScene():
	if currentSceneNode != null:
		currentSceneNode.queue_free()
	
	currentSceneNode = load(nextScene).instantiate() 
	add_child(currentSceneNode)


func on_ChangeScene(newScene)->void:
	fadeScreen.init()
	nextScene = newScene


func on_Exit()->void:
	get_tree().quit()

