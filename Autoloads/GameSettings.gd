extends Node


enum TRANSITIONS {FADE_SCREEN, LEFT_RIGHT, UP_BOTTOM}
enum DIFFICULTY {EASY, NORMAL, HARD}

@onready var gameDifficulty = DIFFICULTY.NORMAL
@onready var fullScreen = false
