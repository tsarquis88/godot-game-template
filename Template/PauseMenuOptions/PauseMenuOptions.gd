extends Panel

signal back

const ENGLISH_INDEX = 0
const SPANISH_INDEX = 1

@onready var m_return_button = find_child("ReturnButton")
@onready var m_language_button = find_child("LanguageButton")
@onready var m_full_screen_button = find_child("FullScreenButton")
@onready var m_music_volume_slider = find_child("MusicVolumeSlider")
@onready var m_sfx_volume_slider = find_child("SfxVolumeSlider")
@onready var m_language_label = find_child("LanguageLabel")
@onready var m_full_screen_label = find_child("FullScreenLabel")
@onready var m_music_volume_label = find_child("MusicVolumeLabel")
@onready var m_sfx_volume_label = find_child("SfxVolumeLabel")
@onready var m_title = find_child("Title")


func _ready():
	set_default_values()
	on_re_translate()
	on_full_screen(false)

	var style_box = get_theme_stylebox("panel")
	style_box.bg_color = Settings.MENU_BACKGROUND_COLOR
	style_box.border_color = Settings.MENU_BORDER_COLOR

	Language.connect("re_translate", self.on_re_translate)
	Resolution.connect("full_screen", self.on_full_screen)
	m_language_button.connect("item_selected", self.on_language_button_item_selected)
	m_full_screen_button.connect("toggled", self.on_full_screen_button_toggled)
	m_return_button.connect("pressed", self.on_return_button_pressed)
	m_music_volume_slider.connect("value_changed", self.on_music_volume_slider_value_changed)
	m_sfx_volume_slider.connect("value_changed", self.on_sfx_volume_slider_value_changed)

	Logger.log_debug("PauseMenuOptions: Ready")


func on_re_translate():
	m_return_button.set_text(tr("RETURN"))
	m_language_label.set_text(tr("LANGUAGE"))
	m_full_screen_label.set_text(tr("FULL-SCREEN"))
	m_music_volume_label.set_text(tr("MUSIC"))
	m_sfx_volume_label.set_text(tr("SFX"))
	m_title.set_text(tr("OPTIONS"))


func on_language_button_item_selected(index):
	match index:
		ENGLISH_INDEX:
			Language.set_language("en")
		SPANISH_INDEX:
			Language.set_language("es")


func set_default_values():
	if Language.get_language() == "es":
		m_language_button.select(SPANISH_INDEX)
	else:
		m_language_button.select(ENGLISH_INDEX)
	m_music_volume_slider.configure_slider(
		0.0001, 0.0001, 1, GameSettings.get_setting("sound", "VOLUME-MUSIC")
	)
	m_sfx_volume_slider.configure_slider(
		0.0001, 0.0001, 1, GameSettings.get_setting("sound", "VOLUME-SFX")
	)


func on_full_screen_button_toggled(full_screen):
	Resolution.set_full_screen(full_screen)


func on_return_button_pressed():
	emit_signal("back")


func on_music_volume_slider_value_changed(new_value):
	SfxManager.set_music_volume(new_value)


func on_sfx_volume_slider_value_changed(new_value):
	SfxManager.set_sfx_volume(new_value)


func on_full_screen(full_screen):
	m_full_screen_button.button_pressed = full_screen
