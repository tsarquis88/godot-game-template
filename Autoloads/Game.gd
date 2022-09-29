extends Node2D


signal ChangeScene
signal Exit


var nextScene


func _ready()->void:
	connect("Exit", self.on_Exit)
	connect("ChangeScene", self.on_ChangeScene)


func on_ChangeScene(scene)->void:
	nextScene = scene 
	switch_scene()


func switch_scene()->void:
	get_tree().change_scene_to_file(nextScene)


func on_Exit()->void:
	get_tree().quit()

