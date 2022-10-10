extends Node


# TODO: Fade


const SFX_FILES_PATH = "res://Assets/SFX/"
const MUSIC_FILES_PATH = "res://Assets/Music/"


@onready var masterVolumeDb = 0.0
@onready var config = ConfigFile.new()


var musicAudioPlayer 

func _ready():
	musicAudioPlayer = AudioStreamPlayer2D.new()
	if config.load(GameSettings.CONFIG_FILE_PATH) == OK:
		setMasterVolumeDb(config.get_value("sound", "VOLUME-DB"))
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
	config.set_value("sound", "VOLUME-DB", newValue)
	var err = config.save(GameSettings.CONFIG_FILE_PATH)
	if err != OK:
		print_debug(str("Error (", err, ") writing into config file"))

