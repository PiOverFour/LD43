extends Node

var agents = []
var target
var average_velocity = Vector2()
var center = Vector2()
#var is_velocity_dirty = true

func set_target(_target):
	target = _target

func add_agent(_agent):
	agents.append(_agent)

func get_agents_in_radius(position, radius=10.0):
	var agents_in_radius = []
	var radius_squared = radius * radius
	for agent in agents:
		if position.distance_squared_to(agent.position) < radius_squared:
			agents_in_radius.append(agent)
	return agents_in_radius

func get_average_velocity():
	# TODO dirty
	var velocity = Vector2(0.0, 0.0)
	for agent in agents:
		velocity += agent.velocity
	velocity /= len(agents)
	average_velocity = velocity

func get_group_center():
	# TODO dirty
	center = Vector2(0.0, 0.0)
	for agent in agents:
		center += agent.position
	center /= len(agents)

func get_group(agent):
    return agents

func _process(delta):
    get_average_velocity()
    get_group_center()
    for agent in agents:
        agent.group = get_group(agent)
        agent.average_velocity = average_velocity
        agent.target = target
        agent.group_center = center