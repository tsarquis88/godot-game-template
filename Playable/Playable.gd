extends Node2D


@onready var target = find_child("Target")
@onready var Game = get_parent()

const nextScene = "res://MainMenu/MainMenu.tscn"


func _ready():
	target.connect("body_entered", self.endGame)


func endGame(_body):
	Game.emit_signal("ChangeScene", nextScene, GameSettings.TRANSITIONS.FADE_SCREEN)
