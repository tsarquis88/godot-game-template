extends Node


enum TRANSITIONS {FADE_SCREEN, LEFT_RIGHT, UP_BOTTOM}
enum DIFFICULTY {EASY, NORMAL, HARD}


const CONFIG_FILE_PATH = "res://config.cfg"


@onready var gameDifficulty = DIFFICULTY.NORMAL
@onready var fullScreen = false
