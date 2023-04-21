extends Node2D

const WIN_SOUND = "win.wav"
const GAME_MUSIC = "playable.ogg"
const INIT_MUSIC = "init.ogg"
const NEXT_SCENE = "res://Template/MainMenu/MainMenu.tscn"

@onready var m_pause = false
@onready var m_pause_menu = find_child("PauseMenu")
@onready var m_pause_menu_options = find_child("PauseMenuOptions")
@onready var m_playable = find_child("Playable")
@onready var m_hud = find_child("HUD")
@onready var m_final_pop_up = find_child("FinalPopUp")
@onready var m_game = get_parent()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Logger.log_debug("Playground: Pause button pressed")

		m_pause = not m_pause
		m_pause_menu.visible = m_pause
		m_pause_menu_options.visible = false
		m_playable.set_pause(m_pause)
		m_hud.set_pause(m_pause)


func _ready():
	m_pause_menu.connect("exit_game", self.on_pause_menu_exit_game)
	m_pause_menu.connect("options", self.on_pause_menu_options)
	m_pause_menu.connect("resume", self.on_pause_menu_resume)
	m_pause_menu_options.connect("back", self.on_pause_menu_options_return)
	m_playable.connect("end", self.on_playable_end)
	m_final_pop_up.visible = false
	m_final_pop_up.connect("accept", self.on_final_pop_up_accept)
	SfxManager.play_music(GAME_MUSIC)

	Logger.log_debug("Playground: Ready")


# Handles the 'end' signal from Playable, showing the PopUp depending on how the game ended.
func on_playable_end(won: bool, score: int):
	Logger.log_debug(str("Playground: Playable ends with won = ", won, " and score = ", score))

	m_playable.set_pause(true)
	m_hud.set_pause(true)

	m_final_pop_up.set_up(won, score)
	m_final_pop_up.visible = true


# Handles the 'exit' button from the pause menu, returning to the MainMenu scene.
func on_pause_menu_exit_game():
	Logger.log_debug("Playground: Exiting playable")

	m_game.emit_signal(
		"change_scene",
		"res://Template/MainMenu/MainMenu.tscn",
		GameSettings.TRANSITIONS.FADE_SCREEN
	)


# Handles the 'resume' button from the pause menu, resuming the game by calling the set_pause()
# method of Playable and HUD scenes.
func on_pause_menu_resume():
	m_playable.set_pause(false)
	m_hud.set_pause(false)
	m_pause_menu.visible = false


# Handles the 'options' button from the pause menu, activating the options menu.
func on_pause_menu_options():
	m_pause_menu.visible = false
	m_pause_menu_options.visible = true


# Handles the 'return' button from the options menu, returning to the pause menu.
func on_pause_menu_options_return():
	m_pause_menu.visible = true
	m_pause_menu_options.visible = false


# Handels the 'accept' button from the pop up, returning to the main menu scene.
func on_final_pop_up_accept():
	SfxManager.play_music(INIT_MUSIC)
	m_game.emit_signal("change_scene", NEXT_SCENE, GameSettings.TRANSITIONS.FADE_SCREEN)
