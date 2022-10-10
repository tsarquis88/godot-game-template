extends Node


# TODO: Fade


const SFX_FILES_PATH = "res://Assets/SFX/"
const MUSIC_FILES_PATH = "res://Assets/Music/"


@onready var masterVolumeDb = 0.0


var musicAudioPlayer 

func _ready():
	musicAudioPlayer = AudioStreamPlayer2D.new()
	setMasterVolumeDb(GameSettings.getSetting("sound", "VOLUME-DB"))
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
	masterVolumeDb = log(newValue) * 20 # Source: https://godotengine.org/qa/40911/best-way-to-create-a-volume-slider
	musicAudioPlayer.set_volume_db(masterVolumeDb)
	GameSettings.setSetting("sound", "VOLUME-DB", newValue)
