extends Node2D


const WIN_SOUND_FILE = "win.wav"


@onready var target = find_child("Target")
@onready var pauseMenu = find_child("PauseMenu")
@onready var pauseMenuOptions = find_child("PauseMenuOptions")
@onready var player = find_child("Player")
@onready var Game = get_parent()


const nextScene = "res://MainMenu/MainMenu.tscn"


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pauseMenu.visible = not pauseMenu.visible
		pauseMenuOptions.visible = false
		player.pause = pauseMenu.visible
		target.setPause(pauseMenu.visible)


func _ready():
	pauseMenu.connect("ExitGame", self.on_pauseMenu_exitGame)
	pauseMenu.connect("Options", self.on_pauseMenu_options)
	pauseMenu.connect("Resume", self.on_pauseMenu_resume)
	pauseMenuOptions.connect("Return", self.on_pauseMenuOptions_return)
	pauseMenuOptions.connect("FullScreen", self.on_pauseMenuOptions_fullScreen)
	target.connect("body_entered", self.endGame)


func endGame(_body):
	SfxManager.play(WIN_SOUND_FILE)
	Game.emit_signal("ChangeScene", nextScene, GameSettings.TRANSITIONS.FADE_SCREEN)


func on_pauseMenu_exitGame():
	Game.emit_signal("ChangeScene", nextScene, GameSettings.TRANSITIONS.FADE_SCREEN)


func on_pauseMenu_resume():
	pauseMenu.visible = false
	player.pause = false
	target.setPause(false)


func on_pauseMenu_options():
	pauseMenu.visible = false
	pauseMenuOptions.visible = true


func on_pauseMenuOptions_return():
	pauseMenu.visible = true
	pauseMenuOptions.visible = false


func on_pauseMenuOptions_fullScreen(fullscreen):
	Game.emit_signal("FullScreen", fullscreen)
