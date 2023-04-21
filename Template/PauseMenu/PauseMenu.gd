extends Panel

signal exit_game
signal options
signal resume

@onready var m_exit_button = find_child("ExitButton")
@onready var m_options_button = find_child("OptionsButton")
@onready var m_resume_button = find_child("ResumeButton")
@onready var m_title = find_child("Title")


func _ready():
	var style_box = get_theme_stylebox("panel")
	style_box.bg_color = Settings.MENU_BACKGROUND_COLOR
	style_box.border_color = Settings.MENU_BORDER_COLOR

	m_exit_button.connect("pressed", self.on_exit_button_pressed)
	m_options_button.connect("pressed", self.on_options_button_pressed)
	m_resume_button.connect("pressed", self.on_resume_button_pressed)
	Language.connect("re_translate", self.re_translate)
	re_translate()

	Logger.log_debug("PauseMenu: Ready")


func on_exit_button_pressed():
	emit_signal("exit_game")


func on_options_button_pressed():
	emit_signal("options")


func on_resume_button_pressed():
	emit_signal("resume")


func re_translate():
	m_exit_button.set_text(tr("EXIT"))
	m_options_button.set_text(tr("OPTIONS"))
	m_resume_button.set_text(tr("RESUME"))
	m_title.set_text(tr("GAME-PAUSED"))
