extends Panel

signal accept

const BUTTON_SOUND = "button.wav"
const SCORES_FILENAME = "res://scores.txt"

@onready var m_title = find_child("Title")
@onready var m_accept_button = find_child("AcceptButton")
@onready var m_text_edit = find_child("TextEdit")
@onready var m_score = 0


func _ready():
	var style_box = get_theme_stylebox("panel")
	style_box.bg_color = Settings.MENU_BACKGROUND_COLOR
	style_box.border_color = Settings.MENU_BORDER_COLOR

	m_accept_button.connect("pressed", self.on_accept_button_pressed)
	m_accept_button.connect("pressed", self.on_button_pressed)
	
	m_accept_button.text = tr("ACCEPT")
	m_text_edit.placeholder_text = tr("ENTER-PLAYER-NAME")
	
	Logger.log_debug("FinalPopUp: Ready")


func set_up(won : bool, score : int):
	if won:
		m_title.text = tr("WON-MESSAGE")
	else:
		m_title.text = tr("LOST-MESSAGE")
	
	m_text_edit.visible = score > 0
	m_score = score


func on_accept_button_pressed():
	var player_name = m_text_edit.text
	if m_text_edit.visible and not player_name.is_empty():
		# Record score into filesystem.
		Logger.log_debug(str("Recording score '", m_score, "' for player '", player_name, "'"))
		var file = FileAccess.open(SCORES_FILENAME, FileAccess.READ_WRITE)
		file.seek_end()
		file.store_csv_line([m_text_edit.text, m_score, Time.get_date_string_from_system()])
		file.close()
		
	
	emit_signal("accept")


func on_button_pressed():
	SfxManager.play_sfx(BUTTON_SOUND)
