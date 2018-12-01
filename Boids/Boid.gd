extends KinematicBody2D

# TODO
## AVOID

var speed = 1.0
export(float) var rotation_speed = 5.0
export(float) var min_speed = 0.5
export(float) var max_speed = 2.0
export(float) var neighbour_min_distance = 3
export(float) var neighbour_detection_distance = 3

export(float) var state_time = 1

var heading = Vector2()

var group = Array()
var average_velocity = Vector2()
var target = Vector2()
var group_center = Vector2()

var flow_direction = Vector2()
var close_bodies = Array()

enum STATE { TARGET, GROUP, ALONE }
export(STATE) var boidState = GROUP

var target = {"follow_target": 0.7, 
			  "follow_group": 0.3,
			  "vortex": 0}

var group = {"follow_target": 0, 
			  "follow_group": 0.7,
			  "vortex": 0.3}

var vortex = {"follow_target": 0, 
			  "follow_group": 0,
			  "vortex": 1}

var v_target = Vector2()
var v_group = Vector2()
var v_avoid = Vector2()
var v_vortex = Vector2()
var v_flee = Vector2()

var lock = false

var animation_speed

onready var timer = $Timer_State


func _ready():
	speed = rand_range(min_speed, max_speed)
	
	var detection = $avoid_detection/neighbour_min_distance
	detection.scale = Vector2(neighbour_min_distance)
	
	heading = Vector2(rand_range(-1, 1), rand_range(-1, 1))
	
	timer.stop()
	timer.wait_time = state_time
	
	# get animation_speed reference to change animation with speed


func _physics_process(delta):
	rd = rand_range(0, 100)
	
	
	
	# if flee
	
	if !lock:
		v_target = target - position
		v_group = group_center - position
		v_vortex = - position
		# avoid
		
		timer.start()
	
	update_state(boidState)


func update_state(boidState):
	match boidState:
		TARGET:
			pass
		GROUP:
			pass
		ALONE:
			pass


func set_direction():
	pass


func _on_Timer_State_timeout():
	lock = false
