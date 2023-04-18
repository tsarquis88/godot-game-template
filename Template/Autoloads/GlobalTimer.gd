extends Node


# Creates a new timeout by creating a new Timer with the specified parameters
#
# callable: callable to be executed when timeout
# timeout: timeout's time in seconds
# autostart: true for autosarting timer
# oneshot: true for only one timeout triggered
#
# Returns a reference to the timer
func create_timeout(
	callable: Callable, timeout: float, autostart: bool = true, oneshot: bool = true
) -> Timer:
	var timer = null
	if not callable.is_valid():
		print_debug("GlobalTimer: create_timeout() called with invalid callable")
	elif timeout <= 0:
		print_debug("GlobalTimer: create_timeout() called with negative timeout")
	else:
		timer = Timer.new()
		timer.set_one_shot(oneshot)
		timer.set_wait_time(timeout)
		timer.connect("timeout", callable)
		timer.autostart = autostart
		add_child(timer)
	return timer


# Stops a timeout
#
# timer: timer's reference returned from create_timeout()
func stop_timeout(timer: Timer) -> void:
	if timer == null:
		print_debug("GlobalTimer: stop_timeout() called with empty timer")
	else:
		timer.set_paused(true)


# Starts a timeout
#
# timer: timer's reference returned from create_timeout()
func start_timeout(timer: Timer) -> void:
	if timer == null:
		print_debug("GlobalTimer: start_timeout() called with empty timer")
	else:
		if timer.is_stopped():
			timer.start()
		timer.set_paused(false)


# Deletes a timeout
#
# timer: timer's reference returned from create_timeout()
func delete_timeout(timer: Timer) -> void:
	if timer == null:
		print_debug("GlobalTimer: delete_timeout() called with empty timer")
	else:
		remove_child(timer)
		timer.queue_free()
