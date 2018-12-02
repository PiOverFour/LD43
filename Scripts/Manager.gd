extends Node

enum BOID_TYPES { RED, YELLOW, BLUE }
	
const boid_names = {
	RED: "RED",
	YELLOW: "YELLOW",
	BLUE: "BLUE",
	}

var sacrificed_boids = {
	'RED': 0,
	'YELLOW': 0,
	'BLUE': 0,
	}
	
var BOID_LIVES = 10


func _ready():
	update_life_bars()
#	for i in range(50):
#		call_deferred("add_boid")

func update_life_bars():
	for type in BOID_TYPES:
#		print(typeof(type))
		get_node("/root/Main/UI/PC/HC/VC/" + type).value = 100 - 100 * sacrificed_boids[type] / BOID_LIVES

#############"
#var agents = []
#var target
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