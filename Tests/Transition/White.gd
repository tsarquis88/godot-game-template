extends ColorRect


var Game


func _ready():
	Game = get_parent()
	GlobalTimer.create_timeout(self.changeScene, 1)

func changeScene():
	Game.emit_signal("ChangeScene", "res://Tests/Transition/Red.tscn", GameSettings.TRANSITIONS.FADE_SCREEN)
