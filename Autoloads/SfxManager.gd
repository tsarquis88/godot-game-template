extends Node


const SFX_FILES_PATH = "res://Assets/SFX/"


@onready var masterVolumeDb = 0


func play(soundName):
	var audioPlayer = AudioStreamPlayer2D.new()
	audioPlayer.stream = load(str(SFX_FILES_PATH, soundName))
	audioPlayer.set_volume_db(masterVolumeDb)
	add_child(audioPlayer)
	audioPlayer.play()


func setMasterVolumeDb(newValue):
	# Source: https://godotengine.org/qa/40911/best-way-to-create-a-volume-slider
	masterVolumeDb = log(newValue) * 20
