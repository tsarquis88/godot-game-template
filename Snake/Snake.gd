extends CharacterBody2D

signal dead

@onready var m_direction = Vector2(1, 0)
@onready var m_body_scene = preload("Body.tscn")
@onready var m_last_global_positions = Array()
@onready var m_body = Array()


func _ready():
	get_parent().connect("clock", self.on_clock)


func _input(event):
	if event is InputEventKey:
		var first_body_position
		if not m_body.is_empty():
			first_body_position = m_body[0].position

		# Set next direction, taking care of not moving towards the first body
		if Input.is_action_just_pressed("ui_up"):
			if first_body_position:
				if first_body_position.y >= 0:
					m_direction = Vector2(0, -1)
			else:
				m_direction = Vector2(0, -1)
		elif Input.is_action_just_pressed("ui_down"):
			if first_body_position:
				if first_body_position.y <= 0:
					m_direction = Vector2(0, 1)
			else:
				m_direction = Vector2(0, 1)
		elif Input.is_action_just_pressed("ui_right"):
			if first_body_position:
				if first_body_position.x <= 0:
					m_direction = Vector2(1, 0)
			else:
				m_direction = Vector2(1, 0)
		elif Input.is_action_just_pressed("ui_left"):
			if first_body_position:
				if first_body_position.x >= 0:
					m_direction = Vector2(-1, 0)
			else:
				m_direction = Vector2(-1, 0)


func on_clock():
	# Move and, if collision, kill snake :(
	if move_and_collide(m_direction * 32):
		emit_signal("dead")

	# Clean unused last positions
	if m_last_global_positions.size() > m_body.size():
		m_last_global_positions.pop_back()

	# Update body positions
	for index in m_body.size():
		m_body[index].global_position = m_last_global_positions[index]

	# Enable collision of first body
	if not m_body.is_empty():
		m_body[0].find_child("CollisionShape2D").disabled = false

	# Store actual position
	m_last_global_positions.push_front(global_position)


func feed():
	# Instantiate and add snake body part without collision (WA bug)
	# The first body part added is the tail
	var new_body_part
	if m_body.is_empty():
		new_body_part = preload("Tail.tscn").instantiate()
	else:
		new_body_part = m_body_scene.instantiate()
	new_body_part.find_child("CollisionShape2D").disabled = true
	call_deferred("add_child", new_body_part)
	m_body.push_front(new_body_part)


func get_size():
	return m_body.size() + 1
