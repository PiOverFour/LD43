extends Node

const LEVELS = {
	"Level0": preload("res://Levels/Level0.tscn"),
	"Level1": preload("res://Levels/Level1.tscn"),
	"Level2": preload("res://Levels/Level2.tscn"),
	"End": preload("res://Levels/End.tscn"),
	}

enum BOID_TYPES { RED, YELLOW, BLUE }
	
var sacrificed_boids = 0
#const boid_names = {
#	RED: "RED",
#	YELLOW: "YELLOW",
#	BLUE: "BLUE",
#	}

#var sacrificed_boids = {
#	'RED': 0,
#	'YELLOW': 0,
#	'BLUE': 0,
#	}
	
var BOID_LIVES = 10


func _ready():
	randomize()
	load_level("Level0")
	update_life_bars()
#	for i in range(50):
#		call_deferred("add_boid")

func update_life_bars():
	if sacrificed_boids == BOID_LIVES:
		game_over()
#	for type in BOID_TYPES:
#		print(typeof(type))
	get_node("/root/Main/UI/PC/HC/VC/SACRIFICED").value = 100 - 100 * sacrificed_boids / BOID_LIVES

func game_over():
#	pass
	get_node("/root/Main/UI/GameOver").visible = true
	get_node("/root/Main/UI/AnimationPlayer").play("GameOver")

func load_level(level):
	# Reset sacrifices
	sacrificed_boids = 0
	update_life_bars()
	
	# Remove level if present
	for c in get_node("/root/Main").get_children():
		if c.name.begins_with("Level"):
			get_node("/root/Main").remove_child(c)
			c.queue_free()
	
	# Load new level
	var level_scene = LEVELS[level].instance()
	get_node("/root/Main").add_child(level_scene)
	get_node("/root/Main").move_child(level_scene, 0)
	
	# Setup camera
	if "bounds" in level_scene:
		var bounds = level_scene.bounds
		var camera = get_node("/root/Main/Player/Camera2D")
		camera.limit_left = -bounds
		camera.limit_top = -bounds
		camera.limit_right = bounds
		camera.limit_bottom = bounds
		camera.zoom = Vector2(1.5, 1.5)
		camera.drag_margin_h_enabled = false
		camera.drag_margin_v_enabled = false
	
	# End Game
	if level == "End":
#		for n in ["Player", "UI"]:
#			var c = get_node("/root/Main/" + n)
#			get_node("/root/Main").remove_child(c)
#			c.queue_free()
		get_node("/root/Main").move_child(level_scene, 2)
		level_scene.find_node("AnimationPlayer").play("End")
		
	
#############
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