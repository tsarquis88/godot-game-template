extends Node2D

signal Transition

# This could be parametrized in init()
const START_DURATION = 0.6
const END_DURATION = 0.6
const WAIT_DURATION = 0.3

@onready var blackBG = find_child("BlackBG")

var property
var startFinalValue
var endFinalValue


func fadeScreenTransition():
	blackBG.modulate.a = 0
	blackBG.size.x = DisplayServer.screen_get_size().x
	blackBG.size.y = DisplayServer.screen_get_size().y
	property = "modulate:a"
	startFinalValue = 1
	endFinalValue = 0
	startTransition()


func leftRightTransition():
	blackBG.modulate.a = 1
	blackBG.size.x = 0
	blackBG.size.y = DisplayServer.screen_get_size().y
	property = "size:x"
	startFinalValue = DisplayServer.screen_get_size().x
	endFinalValue = 0
	startTransition()


func upBottomTransition():
	blackBG.modulate.a = 1
	blackBG.size.x = DisplayServer.screen_get_size().x
	blackBG.size.y = 0
	property = "size:y"
	startFinalValue = DisplayServer.screen_get_size().y
	endFinalValue = 0
	startTransition()


func startTransition():
	startTween(startFinalValue, START_DURATION, self.wait)


func endTransition():
	startTween(endFinalValue, END_DURATION, self.end)


func startTween(finalValue, duration, callback):
	var tween = create_tween()
	tween.tween_property(blackBG, property, finalValue, duration)
	tween.tween_callback(callback)


func wait():
	emit_signal("Transition")
	GlobalTimer.create_timeout(self.endTransition, WAIT_DURATION)


func end():
	pass
