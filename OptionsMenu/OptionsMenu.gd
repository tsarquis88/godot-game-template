extends BoxContainer

signal full_screen

const MAINMENU_SCENE = "res://MainMenu/MainMenu.tscn"
const ENGLISH_INDEX = 0
const SPANISH_INDEX = 1
const EASY_INDEX = 0
const NORMAL_INDEX = 1
const HARD_INDEX = 2
const SLIDER_SOUND = "volumeSlider.wav"
const BUTTON_SOUND = "button.wav"

@onready var m_panel = find_child("Panel")
@onready var m_background = find_child("Background")
@onready var m_return_button = find_child("ReturnButton")
@onready var m_language_button = find_child("LanguageButton")
@onready var m_difficulty_button = find_child("DifficultyButton")
@onready var m_full_screen_button = find_child("FullScreenButton")
@onready var m_volume_slider = find_child("VolumeSlider")
@onready var m_language_label = find_child("LanguageLabel")
@onready var m_difficulty_label = find_child("DifficultyLabel")
@onready var m_full_screen_label = find_child("FullScreenLabel")
@onready var m_volume_label = find_child("VolumeLabel")
@onready var m_game = get_parent()


func _ready():
	set_default_values()
	on_re_translate()
	on_fullScreen(false)
	m_panel.get_theme_stylebox("m_panel").bg_color = Settings.MENU_m_panel_COLOR
	m_background.color = Settings.MENU_BACKGROUND_COLOR
	m_return_button.connect("pressed", self.on_return_button_pressed)
	m_language_button.connect("item_selected", self.on_language_button_item_selected)
	m_difficulty_button.connect("item_selected", self.on_difficulty_button_item_selected)
	m_full_screen_button.connect("toggled", self.on_full_screen_button_toggled)
	m_volume_slider.connect("value_changed", self.on_volume_slider_value_changed)
	m_volume_slider.connect("drag_ended", self.on_volume_slider_drag_ended)
	Language.connect("re_translate", self.on_re_translate)
	Resolution.connect("full_screen", self.on_fullScreen)

	Logger.log_debug("OptionsMenu: Ready")


func on_return_button_pressed():
	m_game.emit_signal("change_scene", MAINMENU_SCENE, GameSettings.TRANSITIONS.UP_BOTTOM)
	SfxManager.play_sfx(BUTTON_SOUND)


func on_language_button_item_selected(index):
	match index:
		ENGLISH_INDEX:
			Language.set_language("en")
		SPANISH_INDEX:
			Language.set_language("es")


func on_difficulty_button_item_selected(index):
	match index:
		EASY_INDEX:
			GameSettings.m_game_difficulty = GameSettings.DIFFICULTY.EASY
		NORMAL_INDEX:
			GameSettings.m_game_difficulty = GameSettings.DIFFICULTY.NORMAL
		HARD_INDEX:
			GameSettings.m_game_difficulty = GameSettings.DIFFICULTY.HARD


func on_full_screen_button_toggled(full_screen):
	Resolution.set_full_screen(full_screen)


func on_volume_slider_value_changed(_new_value):
	SfxManager.play_sfx(SLIDER_SOUND)


func on_volume_slider_drag_ended(value_changed):
	if value_changed:
		SfxManager.set_master_volume_db(m_volume_slider.value)


func on_re_translate():
	m_difficulty_button.set_item_text(EASY_INDEX, tr("EASY"))
	m_difficulty_button.set_item_text(NORMAL_INDEX, tr("NORMAL"))
	m_difficulty_button.set_item_text(HARD_INDEX, tr("HARD"))
	m_return_button.text = tr("RETURN")
	m_language_label.text = tr("LANGUAGE")
	m_difficulty_label.text = tr("DIFFICULTY")
	m_full_screen_label.text = tr("FULL-SCREEN")
	m_volume_label.text = tr("VOLUME")


func set_default_values():
	if Language.get_language() == "es":
		m_language_button.select(SPANISH_INDEX)
	else:
		m_language_button.select(ENGLISH_INDEX)
	m_difficulty_button.select(NORMAL_INDEX)
	m_volume_slider.step = 0.0001
	m_volume_slider.min_value = 0.0001
	m_volume_slider.max_value = 1
	m_volume_slider.value = 1


func on_full_screen(full_screen):
	m_full_screen_button.button_pressed = full_screen
