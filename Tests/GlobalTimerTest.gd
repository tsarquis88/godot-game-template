extends Node2D


var timers = []

func _ready():
	$Control/NewTimerMenu/ButtonCreate.connect("pressed", Callable(self, "create_timeout"))
	$Control/Timers/HBoxContainer/ButtonStart.connect("pressed", Callable(self, "start_timeout"))
	$Control/Timers/HBoxContainer/ButtonStop.connect("pressed", Callable(self, "stop_timeout"))
	$Control/Timers/HBoxContainer/ButtonDelete.connect("pressed", Callable(self, "delete_timeout"))


func create_timeout():
	var new_timer = GlobalTimer.create_timeout(self, "print_text", 
		$Control/NewTimerMenu/TimeValue.value, 
		$Control/NewTimerMenu/AutostartValue.is_pressed(),
		$Control/NewTimerMenu/OneshotValue.is_pressed())
	timers.append(new_timer)
	print("Timers has ",len(timers), " timers.")
	$Control/Timers/ItemList.add_item($Control/NewTimerMenu/NameValue.get_text())


func start_timeout():
	if $Control/Timers/ItemList.is_anything_selected():
		var timer_val = $Control/Timers/ItemList.get_selected_items()[0]
		print("Timer: ",timers[timer_val]," about to be started.")
		GlobalTimer.start_timeout(timers[timer_val])


func stop_timeout():
	if $Control/Timers/ItemList.is_anything_selected():
		var timer_val = $Control/Timers/ItemList.get_selected_items()[0]
		print("Timer: ",timers[timer_val]," about to be stopped.")
		GlobalTimer.stop_timeout(timers[timer_val])


func delete_timeout():
	if $Control/Timers/ItemList.is_anything_selected():
		var timer_val = $Control/Timers/ItemList.get_selected_items()[0]
		print("Timer: ",timers[timer_val]," about to be deleted.")
		$Control/Timers/ItemList.remove_item(timer_val)
		GlobalTimer.delete_timeout(timers[timer_val])
		timers.pop_at(timer_val)


func print_text():
	$Control/Panel/Console.append_text("Timer")
