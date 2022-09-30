extends Node2D


signal ChangeScene
signal Exit


func _ready()->void:
	connect("Exit", self.on_Exit)
	connect("ChangeScene", self.on_ChangeScene)


func on_ChangeScene(newScene)->void:
	get_tree().change_scene_to_file(newScene)


func on_Exit()->void:
	get_tree().quit()

