extends ColorRect


var Game


func _ready():
	Game = get_parent()
	var timer = Timer.new()
	timer.wait_time = 1
	timer.autostart = true
	timer.one_shot = true
	timer.connect("timeout", self.changeScene)
	add_child(timer)
	timer.start()


func changeScene():
	Game.emit_signal("ChangeScene", "res://Tests/Transition/Red.tscn")
