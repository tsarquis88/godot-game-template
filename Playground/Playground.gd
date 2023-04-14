extends Node2D


const WIN_SOUND = "win.wav"
const GAME_MUSIC = "playable.ogg"
const INIT_MUSIC = "init.ogg"


@onready var m_pause = false
@onready var pauseMenu = find_child("PauseMenu")
@onready var pauseMenuOptions = find_child("PauseMenuOptions")
@onready var playable = find_child("Playable")
@onready var Game = get_parent()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Logger.logDebug("Playground: Pause button pressed")
		
		m_pause = not m_pause
		pauseMenu.visible = m_pause
		pauseMenuOptions.visible = false
		playable.setPause(m_pause)


func _ready():
	pauseMenu.connect("ExitGame", self.on_pauseMenu_exitGame)
	pauseMenu.connect("Options", self.on_pauseMenu_options)
	pauseMenu.connect("Resume", self.on_pauseMenu_resume)
	pauseMenuOptions.connect("Return", self.on_pauseMenuOptions_return)
	playable.connect("End", self.on_playableEnd)
	SfxManager.playMusic(GAME_MUSIC)
	
	Logger.logDebug("Playground: Ready")


func on_playableEnd(won : bool):
	Logger.logDebug(str("Playground: Playable ends with won = ", won))
	
	var nextScene
	
	if won:
		SfxManager.playSfx(WIN_SOUND)
		nextScene = "res://WonScreen/WonScreen.tscn"
	else:
		# SfxManager.playSfx(LOST_SOUND)
		nextScene = "res://LostScreen/LostScreen.tscn"
	
	SfxManager.playMusic(INIT_MUSIC)
	Game.emit_signal("ChangeScene", nextScene, GameSettings.TRANSITIONS.FADE_SCREEN)


func on_pauseMenu_exitGame():
	Logger.logDebug("Playground: Exiting playable")
	
	Game.emit_signal("ChangeScene", "res://MainMenu/MainMenu.tscn", GameSettings.TRANSITIONS.FADE_SCREEN)


func on_pauseMenu_resume():
	playable.setPause(false)
	pauseMenu.visible = false


func on_pauseMenu_options():
	pauseMenu.visible = false
	pauseMenuOptions.visible = true


func on_pauseMenuOptions_return():
	pauseMenu.visible = true
	pauseMenuOptions.visible = false
