extends Node2D


signal Waiting


# This could be parametrized in init()
const FADEIN_DURATION = 1
const FADEOUT_DURATION = 1
const WAIT_DURATION = 0.3


@onready var fadeIn = true
@onready var blackBG = find_child("BlackBG")


func init():
	startFade()


func startFade():
	var finalValue
	var callBack
	var fadeTime
	
	if fadeIn:
		finalValue = 1
		callBack = self.wait
		fadeTime = FADEIN_DURATION
	else:
		finalValue = 0
		callBack = self.end
		fadeTime = FADEOUT_DURATION
	
	var tween = create_tween()
	tween.tween_property(blackBG, "modulate:a", finalValue, fadeTime)
	tween.tween_callback(callBack)


func wait():
	emit_signal("Waiting")
	fadeIn = false
	
	###### TODO: GT
	var timer = Timer.new()
	timer.wait_time = WAIT_DURATION
	timer.autostart = true
	timer.one_shot = true
	timer.connect("timeout", self.startFade)
	add_child(timer)
	timer.start()


func end():
	fadeIn = true
