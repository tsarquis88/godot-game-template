extends Node2D


const MAX_SCORES_TO_SHOW = 5


@onready var m_return_scene = "res://Template/MainMenu/MainMenu.tscn"
@onready var m_title = find_child("Title")
@onready var m_background = find_child("Background")
@onready var m_vbox_container = find_child("VBoxContainer")
@onready var m_first_table_row = find_child("FirstTableRow")
@onready var m_game = get_parent()
@onready var m_table_row_scene = preload("res://Template/ScoreTable/TableRow.tscn")


func _ready():
	m_background.color = Settings.MENU_BACKGROUND_COLOR
	m_title.text = tr("SCORE-TABLE")
	m_first_table_row.set_row(tr("PLAYER-NAME"), tr("SCORE"))
	
	# String array with the struct: [player_name, score, date].
	var scores = Array()
	
	# Read each CSV score into memory.
	var file = FileAccess.open("res://scores.txt", FileAccess.READ)
	var new_line = file.get_csv_line()
	while new_line.size() > 1:
		scores.push_back(new_line)
		new_line = file.get_csv_line()
	file = null
	
	# Merge sort scores.
	for i in range(0, scores.size()):
		var score = scores[i]
		var j = i
		while j > 0 and int(scores[j - 1][1]) < int(score[1]):
			scores[j] = scores[j - 1]
			j -= 1
		scores[j] = score;
	
	# Take the scores into scene.
	for i in MAX_SCORES_TO_SHOW:
		var new_table_row = m_table_row_scene.instantiate()
		m_vbox_container.add_child(new_table_row)
		new_table_row.set_row(scores[i][0], scores[i][1])
	
	Logger.log_debug("ScoreTable: Ready")


func _input(event):
	if event is InputEventKey and event.pressed:
		m_game.emit_signal("change_scene", m_return_scene, GameSettings.TRANSITIONS.LEFT_RIGHT)
