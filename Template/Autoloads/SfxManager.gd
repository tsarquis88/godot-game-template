extends Node

# TODO: Fade

@onready var m_music_audio_player = AudioStreamPlayer2D.new()
@onready var m_music_volume_db = 0.0
@onready var m_sfx_volume_db = 0.0


func _ready():
	set_music_volume(GameSettings.get_music_volume())
	set_sfx_volume(GameSettings.get_sfx_volume())
	add_child(m_music_audio_player)


func play_sfx(sound_stream: AudioStream):
	var sfx_audio_player = AudioStreamPlayer2D.new()
	sfx_audio_player.stream = sound_stream
	sfx_audio_player.set_volume_db(m_sfx_volume_db)
	add_child(sfx_audio_player)
	sfx_audio_player.play()


func play_music(music_stream: AudioStream):
	m_music_audio_player.stop()
	m_music_audio_player.set_volume_db(m_music_volume_db)
	m_music_audio_player.stream = music_stream
	m_music_audio_player.play()


# Sets the music volume given a linear (from 0 to 1) scale.
func set_music_volume(new_value):
	# Source: https://godotengine.org/qa/40911/best-way-to-create-a-volume-slider
	m_music_volume_db = log(new_value) * 20
	m_music_audio_player.set_volume_db(m_music_volume_db)
	GameSettings.change_music_volume(new_value)


# Sets the SFX volume given a linear (from 0 to 1) scale.
func set_sfx_volume(new_value):
	# Source: https://godotengine.org/qa/40911/best-way-to-create-a-volume-slider
	m_sfx_volume_db = log(new_value) * 20
	GameSettings.change_sfx_volume(new_value)
