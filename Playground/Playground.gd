extends Node2D


const WIN_SOUND = "win.wav"
const GAME_MUSIC = "playable.ogg"
const INIT_MUSIC = "init.ogg"


@onready var m_pause = false
@onready var m_pauseMenu = find_child("PauseMenu")
@onready var m_pauseMenuOptions = find_child("PauseMenuOptions")
@onready var m_playable = find_child("Playable")
@onready var Game = get_parent()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Logger.logDebug("Playground: Pause button pressed")
		
		m_pause = not m_pause
		m_pauseMenu.visible = m_pause
		m_pauseMenuOptions.visible = false
		m_playable.setPause(m_pause)


func _ready():
	m_pauseMenu.connect("ExitGame", self.on_pauseMenu_exitGame)
	m_pauseMenu.connect("Options", self.on_pauseMenu_options)
	m_pauseMenu.connect("Resume", self.on_pauseMenu_resume)
	m_pauseMenuOptions.connect("Return", self.on_pauseMenuOptions_return)
	m_playable.connect("End", self.on_playableEnd)
	SfxManager.playMusic(GAME_MUSIC)
	
	Logger.logDebug("Playground: Ready")


# Handles the End signal from Playable, changing the scene to the WonScreen
# or LostScreen scene depending of the game results.
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


# Handles the 'exit' button from the pause menu, returning to the MainMenu scene.
func on_pauseMenu_exitGame():
	Logger.logDebug("Playground: Exiting playable")
	
	Game.emit_signal("ChangeScene", "res://MainMenu/MainMenu.tscn", GameSettings.TRANSITIONS.FADE_SCREEN)


# Handles the 'resume' button from the pause menu, resuming the game.
func on_pauseMenu_resume():
	m_playable.setPause(false)
	m_pauseMenu.visible = false


# Handles the 'options' button from the pause menu, activating the options menu.
func on_pauseMenu_options():
	m_pauseMenu.visible = false
	m_pauseMenuOptions.visible = true


# Handles the 'return' button from the options menu, returning to the 
# pause menu.
func on_pauseMenuOptions_return():
	m_pauseMenu.visible = true
	m_pauseMenuOptions.visible = false
