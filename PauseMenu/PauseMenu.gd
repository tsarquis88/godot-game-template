extends Panel


signal ExitGame


@onready var exitButton = find_child("ExitButton")


func _ready():
	exitButton.connect("pressed", self.on_exitButton_pressed)


func on_exitButton_pressed():
	emit_signal("ExitGame")

