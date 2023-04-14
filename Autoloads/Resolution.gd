extends Node

signal full_screen

const DEFAULT_SCALE = Vector2(1, 1)

@onready var m_is_full_screen = false
@onready var m_block_size_changed = false


func _ready():
	get_tree().get_root().connect("size_changed", self.on_size_changed)

	Logger.log_debug("Resolution autoload: Ready")


func set_full_screen(new_full_screen):
	m_is_full_screen = new_full_screen
	m_block_size_changed = true
	if new_full_screen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	emit_signal("full_screen", m_is_full_screen)
	GlobalTimer.create_timeout(self.unblock_size_changed, 0.5)


func unblock_size_changed():
	m_block_size_changed = false


func on_size_changed():
	if m_block_size_changed:
		return
	set_full_screen(not m_is_full_screen)
