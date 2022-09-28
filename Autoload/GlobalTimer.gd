extends Node2D


# Creates a new timeout by creating a new Timer with the specified parameters
#
# node: node that will execute the timeout's function
# function: name of the timeout's function
# timeout: timeout's time in seconds
# autostart: true for autosarting timer
# oneshot: true for only one timeout triggered
#
# Returns a reference to the timer
func create_timeout(node : Node, function : String, timeout : float, 
					autostart : bool = true , oneshot : bool = true)->Timer:
	var timer = null
	if node == null:
		print_debug("GlobalTimer: create_timeout() called with empty node")
	elif not node.has_method(function):
		print_debug("GlobalTimer: create_timeout() called with wrong function's name")
	elif timeout <= 0:
		print_debug("GlobalTimer: create_timeout() called with non-positive timeout")
	else:
		timer = Timer.new()
		timer.set_one_shot(oneshot)
		timer.set_wait_time(timeout)
		timer.connect("timeout", Callable( node, function) )
		timer.autostart = autostart
		add_child(timer)
	return timer


# Stops a timeout
#
# timer: timer's reference returned from create_timeout()
func stop_timeout(timer : Timer)->void:
	if timer == null:
		print_debug("GlobalTimer: stop_timeout() called with empty timer")
	else:
		timer.stop()


# Starts a timeout
#
# timer: timer's reference returned from create_timeout()
func start_timeout(timer : Timer)->void:
	if timer == null:
		print_debug("GlobalTimer: start_timeout() called with empty timer")
	else:
		timer.start()


# Deletes a timeout
#
# timer: timer's reference returned from create_timeout()
func delete_timeout(timer : Timer)->void:
	if timer == null:
		print_debug("GlobalTimer: delete_timeout() called with empty timer")
	else:
		remove_child(timer)
		timer.queue_free()
