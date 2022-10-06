extends Node2D


@onready var target = find_child("Target")
@onready var pauseMenu = find_child("PauseMenu")
@onready var player = find_child("Player")
@onready var Game = get_parent()

const nextScene = "res://MainMenu/MainMenu.tscn"


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pauseMenu.visible = not pauseMenu.visible
		player.pause = pauseMenu.visible
		


func _ready():
	pauseMenu.connect("ExitGame", self.on_pauseMenu_exitGame)
	target.connect("body_entered", self.endGame)


func endGame(_body):
	Game.emit_signal("ChangeScene", nextScene, GameSettings.TRANSITIONS.FADE_SCREEN)


func on_pauseMenu_exitGame():
	Game.emit_signal("ChangeScene", nextScene, GameSettings.TRANSITIONS.FADE_SCREEN)
