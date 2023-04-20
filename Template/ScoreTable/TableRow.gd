extends HBoxContainer


@onready var m_player_name_label = find_child("PlayerNameLabel")
@onready var m_score_label = find_child("ScoreLabel")


func set_row(player_name : String, score : String):
	m_player_name_label.text = player_name
	m_score_label.text = score
