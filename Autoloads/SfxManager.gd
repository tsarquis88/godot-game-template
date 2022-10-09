extends Node


# TODO: Fade


const SFX_FILES_PATH = "res://Assets/SFX/"
const MUSIC_FILES_PATH = "res://Assets/Music/"


@onready var masterVolumeDb = 0


var musicAudioPlayer 

func _ready():
	musicAudioPlayer = AudioStreamPlayer2D.new()
	add_child(musicAudioPlayer)


func playSfx(soundName):
	var sfxAudioPlayer = AudioStreamPlayer2D.new()
	sfxAudioPlayer.stream = load(str(SFX_FILES_PATH, soundName))
	sfxAudioPlayer.set_volume_db(masterVolumeDb)
	add_child(sfxAudioPlayer)
	sfxAudioPlayer.play()


func playMusic(musicName):
	musicAudioPlayer.stop()
	musicAudioPlayer.set_volume_db(masterVolumeDb)
	musicAudioPlayer.stream = load(str(MUSIC_FILES_PATH, musicName))
	musicAudioPlayer.play()

func setMasterVolumeDb(newValue):
	# Source: https://godotengine.org/qa/40911/best-way-to-create-a-volume-slider
	masterVolumeDb = log(newValue) * 20
	musicAudioPlayer.set_volume_db(masterVolumeDb)
