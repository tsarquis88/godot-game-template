extends BoxContainer

const PLAYGROUND_SCENE = "res://Template/Playground/Playground.tscn"
const CREDITS_SCENE = "res://Template/Credits/Credits.tscn"
const OPTIONS_SCENE = "res://Template/OptionsMenu/OptionsMenu.tscn"
const SCORE_TABLE_SCENE = "res://Template/ScoreTable/ScoreTable.tscn"
const BUTTON_SOUND = "button.wav"

@onready var m_background = find_child("Background")
@onready var m_new_game_button = find_child("NewGameButton")
@onready var m_options_button = find_child("OptionsButton")
@onready var m_score_table_button = find_child("ScoreTableButton")
@onready var m_credits_button = find_child("CreditsButton")
@onready var m_exit_button = find_child("ExitButton")
@onready var m_made_with_label = find_child("MadeWithLabel")
@onready var m_game = get_parent()


func _ready():
	m_background.color = Settings.MENU_BACKGROUND_COLOR
	m_new_game_button.connect("pressed", self.on_new_game_button_pressed)
	m_options_button.connect("pressed", self.on_options_button_pressed)
	m_score_table_button.connect("pressed", self.on_score_table_button_pressed)
	m_credits_button.connect("pressed", self.on_credits_button_pressed)
	m_exit_button.connect("pressed", self.on_exit_button_pressed)
	m_new_game_button.connect("pressed", self.on_button_pressed)
	m_options_button.connect("pressed", self.on_button_pressed)
	m_score_table_button.connect("pressed", self.on_button_pressed)
	m_credits_button.connect("pressed", self.on_button_pressed)
	m_exit_button.connect("pressed", self.on_button_pressed)
	Language.connect("re_translate", self.re_translate)
	re_translate()

	Logger.log_debug("MainMenu: Ready")


func on_new_game_button_pressed():
	m_game.emit_signal("change_scene", PLAYGROUND_SCENE, GameSettings.TRANSITIONS.FADE_SCREEN)


func on_options_button_pressed():
	m_game.emit_signal("change_scene", OPTIONS_SCENE, GameSettings.TRANSITIONS.LEFT_RIGHT)


func on_credits_button_pressed():
	m_game.emit_signal("change_scene", CREDITS_SCENE, GameSettings.TRANSITIONS.UP_BOTTOM)


func on_score_table_button_pressed():
	m_game.emit_signal("change_scene", SCORE_TABLE_SCENE, GameSettings.TRANSITIONS.UP_BOTTOM)


func on_exit_button_pressed():
	m_game.emit_signal("exit")


func on_button_pressed():
	SfxManager.play_sfx(BUTTON_SOUND)


func re_translate():
	m_new_game_button.text = tr("NEW-GAME")
	m_options_button.text = tr("OPTIONS")
	m_score_table_button.text = tr("SCORE-TABLE")
	m_credits_button.text = tr("CREDITS")
	m_made_with_label.text = str(tr("MADE-WITH"), " Godot ", Engine.get_version_info().string)
	m_exit_button.text = tr("EXIT")
