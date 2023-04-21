extends HBoxContainer

@onready var m_player_name_label = find_child("PlayerNameLabel")
@onready var m_score_label = find_child("ScoreLabel")
@onready var m_date_label = find_child("DateLabel")


func set_row(player_name: String, score: String, date: String):
	m_player_name_label.text = player_name
	m_score_label.text = score
	m_date_label.text = date
