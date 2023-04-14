extends Area2D

@onready var particles = find_child("CpuParticles2d")


func setPause(pause):
	if pause:
		particles.speed_scale = 0
	else:
		particles.speed_scale = 1
