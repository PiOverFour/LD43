extends KinematicBody2D

var speed
export(float) var rotation_speed = 5.0
export(float) var min_speed = 0.5
export(float) var max_speed = 1
export(float) var neighbour_min_distance = 5
export(float) var group_detection_distance = 30
export(float) var target_detection_distance = 300

export(float) var state_time = 0.2

var heading = Vector2()

export(bool) var group = false
var average_velocity = Vector2(1,1)
var target = Vector2(0,0)
var group_center = Vector2()

var flow_direction = Vector2()
var close_bodies = Array()

enum STATE { TARGET, GROUP, ALONE }
export(STATE) var boidState = GROUP

export(float) var target_follow = 0.7 
export(float) var target_follow_group = 0.3
export(float) var target_vortex = 0

export(float) var group_follow = 1
export(float) var group_vortex = 0

export(float) var alone_vortex = 0.2
export(float) var alone_wander = 0.3

var v_target = Vector2()
var v_group = Vector2()
var v_group_center = Vector2()
var v_avoid = Vector2()
var v_vortex = Vector2()
var v_flee = Vector2()
var v_wander = Vector2()

var lock = false

var animation_speed

onready var timer = $Timer_State
onready var avoid_detection = $avoid_detection
onready var group_detection = $group_detector

onready var player = get_node("../Player")

func _ready():
	speed = rand_range(min_speed, max_speed)
	
	var detection_zone = $avoid_detection/neighbour_min_distance
	detection_zone.scale = Vector2(neighbour_min_distance, neighbour_min_distance)
	
	var group_detection_zone = $group_detector/group_distance
	group_detection_zone.scale = Vector2(group_detection_distance, group_detection_distance)
	
	heading = Vector2(rand_range(-1, 1), rand_range(-1, 1))
	
	timer.stop()
	timer.wait_time = state_time
	
	# get animation_speed reference to change animation with speed


func _process(delta):
	# if flee
	
	if !lock:
		lock = true
		
		# set vectors
		target = player.position
		v_target = target - position
		
		v_vortex = - position
		
		# avoid
		if avoid_detection.avoid_position != Vector2(0,0):
			v_avoid = position - avoid_detection.avoid_position
			v_avoid = v_avoid.normalized()
		else:
			v_avoid = Vector2(0,0)
		
#		print(group_detection.count)
		
		# set state
		if v_target.length() < target_detection_distance:
			boidState = STATE.TARGET
		elif group_detection.count > 1:
			boidState = STATE.GROUP
		else:
			boidState = STATE.ALONE
		
#		print(boidState)
		timer.start()
	
	update_state(boidState)

	move_and_slide(heading * speed)


func update_state(boidState):
	heading = Vector2(0, 0)
	v_wander = Vector2(rand_range(-1, 1), rand_range(-1, 1))
	match boidState:
		TARGET:
#			print("target")
			if v_avoid == Vector2(0,0):
				heading = v_target * target_follow + v_group * target_follow_group + v_vortex * target_vortex
			else:
				heading = v_target * target_follow + v_group * target_follow_group + v_vortex * target_vortex
				heading = (v_avoid + heading.normalized()) * heading.length() / 2
		GROUP:
#			print("group")
			v_group = group_detection.average_heading
			v_group_center = group_detection.group_position - position
			if v_avoid == Vector2(0,0):
				heading = v_group * group_follow + v_vortex * group_vortex
			else:
				heading = v_group * group_follow + v_vortex * group_vortex
				heading = (v_avoid + heading.normalized()) * heading.length() / 2
		ALONE:
#			print("alone")
			heading = v_vortex * alone_vortex + v_wander * alone_wander


func _on_Timer_State_timeout():
	timer.stop()
	lock = false
