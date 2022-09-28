extends Node2D


signal ChangeScene
signal Exit


@onready var currentScene = null
var nextScene


func _ready()->void:
	connect("Exit", self.on_Exit)
	connect("ChangeScene", self.on_ChangeScene)


func on_ChangeScene(scene)->void:
	nextScene = scene 
	switch_scene()


func switch_scene()->void:
	currentScene = nextScene
	nextScene = null
	get_tree().change_scene_to_file(currentScene)


func on_Exit()->void:
	get_tree().quit()

