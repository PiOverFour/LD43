extends Node

var boid_node = preload("res://Boids/boid.tscn")
var boid_radius = 800
onready var timer = Timer.new()

func _ready():
	# Set up boid instancing
	timer.wait_time = 1
	timer.connect("timeout", self, "add_boid")
	timer.autostart = false
	timer.process_mode = timer.TIMER_PROCESS_PHYSICS
#	timer.start()
	add_child(timer)
	print(timer.is_stopped())
#	for i in range(50):
#		call_deferred("add_boid")

func add_boid():
#	print("Adding boid...")
	var boid_instance = boid_node.instance()
	var angle = rand_range(-PI, PI)
	boid_instance.position = Vector2(cos(angle), sin(angle))*boid_radius
#	get_tree().root.add_child(boid_instance)
	get_node("/root/Main").add_child(boid_instance)

#var agents = []
var target
#var average_velocity = Vector2()
#var center = Vector2()
##var is_velocity_dirty = true
#
#func set_target(_target):
#	target = _target
#
#func add_agent(_agent):
#	agents.append(_agent)
#
#func get_agents_in_radius(position, radius=10.0):
#	var agents_in_radius = []
#	var radius_squared = radius * radius
#	for agent in agents:
#		if position.distance_squared_to(agent.position) < radius_squared:
#			agents_in_radius.append(agent)
#	return agents_in_radius
#
#func get_average_velocity():
#	# TODO dirty
#	var velocity = Vector2(0.0, 0.0)
#	for agent in agents:
#		velocity += agent.velocity
#	velocity /= len(agents)
#	average_velocity = velocity
#
#func get_group_center():
#	# TODO dirty
#	center = Vector2(0.0, 0.0)
#	for agent in agents:
#		center += agent.position
#	center /= len(agents)
#
#func get_group(agent):
#    return agents
#
#func _process(delta):
#    get_average_velocity()
#    get_group_center()
#    for agent in agents:
#        agent.group = get_group(agent)
#        agent.average_velocity = average_velocity
#        agent.target = target
#        agent.group_center = center