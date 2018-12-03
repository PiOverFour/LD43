extends KinematicBody2D

enum TYPE { RED, YELLOW, BLUE }
export(TYPE) var boidType = TYPE.RED

var speed
var previous_speed
export(float) var rotation_speed = 5.0
var min_speed = 30
var max_speed = 200
var neighbour_min_distance = 10
var group_detection_distance = 70
var target_detection_distance = 600

export(float) var state_time = 0.2

var heading = Vector2()
var previous_heading = Vector2()

export(bool) var group = false
var average_velocity = Vector2(1,1)
var target = Vector2(0,0)
var group_center = Vector2()

var flow_direction = Vector2()
var close_bodies = Array()

enum STATE { TARGET, GROUP, ALONE, ATTRACTED, REPULSED }
export(STATE) var boidState = STATE.ALONE

var target_follow = 0.8
var target_follow_group = 0.2
var target_vortex = 0

var group_follow = 0.4
var group_vortex = 0.2

var alone_vortex = 0.4
var alone_wander = 0.2

var v_target = Vector2()
var v_group = Vector2()
var v_group_center = Vector2()
var v_avoid = Vector2()
var v_vortex = Vector2()
var v_flee = Vector2()
var v_wander = Vector2()

var v_door_repulse = Vector2()
var totem_position = Vector2()

var lock = false

var animation_speed


onready var timer = $Timer_State
onready var avoid_detection = $avoid_detection
onready var group_detection = $group_detector

onready var player = get_node("../../Player")

onready var timer_sound = $Timer_Sound

onready var animation_player = $AnimatedSprite

func _ready():
	# Set sound up
	$Bubble.pitch_scale = rand_range(0.25, 2)
	
	speed = rand_range(min_speed, max_speed)
	previous_speed = speed
	
	var detection_zone = $avoid_detection/neighbour_min_distance
	detection_zone.scale = Vector2(neighbour_min_distance, neighbour_min_distance)
	
	var group_detection_zone = $group_detector/group_distance
	group_detection_zone.scale = Vector2(group_detection_distance, group_detection_distance)
	
	heading = Vector2(rand_range(-1, 1), rand_range(-1, 1))
	
	timer.stop()
	timer.wait_time = state_time
	
	# get animation_speed reference to change animation with speed


func _process(delta):
	
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
		
		
#		print("set state")
#		print(boidState)
		if boidState != STATE.ATTRACTED:
			# set state
			if v_target.length() < target_detection_distance:
				boidState = STATE.TARGET
			elif group_detection.count > 1:
				boidState = STATE.GROUP
			else:
				boidState = STATE.ALONE
		
#		print(boidState)
		
		update_state(boidState)
	
	
	heading = previous_heading * 0.5 + 0.5 * heading
	speed = previous_speed * 0.8 + speed * 0.2
	speed = clamp(speed, min_speed, max_speed)
	move_and_slide(heading.normalized() * speed)
	previous_heading = heading
	previous_speed = speed


func update_state(boidState):
	
	heading = Vector2(0, 0)
	v_wander = Vector2(rand_range(-1, 1), rand_range(-1, 1))
	match boidState:
		TARGET:
#			print("target")
			speed = player.VELOCITY.length_squared()
			if v_avoid == Vector2(0,0):
				heading = v_target * target_follow + v_group * target_follow_group + v_vortex * target_vortex
			else:
				heading = v_target * target_follow + v_group * target_follow_group + v_vortex * target_vortex
				heading = (v_avoid * 0.3 + 0.7 * heading.normalized()) * heading.length_squared()
		GROUP:
#			print("group")
			v_group = group_detection.average_heading
			v_group_center = group_detection.group_position - position
			speed = group_detection.speed
			if v_avoid == Vector2(0,0):
				heading = v_group.normalized() * group_follow + v_vortex.normalized() * group_vortex
			else:
				heading = v_group.normalized() * group_follow + v_vortex.normalized() * group_vortex
				heading = (v_avoid * 0.3 + 0.7 * heading.normalized()) * heading.length_squared()
		ALONE:
#			print("alone")
			speed = min_speed
			heading = v_vortex.normalized() * alone_vortex + v_wander.normalized() * alone_wander
		REPULSED:
#			print("REPULSED")
			speed = min_speed * max_speed / 2
			heading = v_door_repulse.normalized()
			timer.wait_time = 1
		ATTRACTED:
#			print("ATTRACTED")
			speed = min_speed * max_speed / 2
			heading = totem_position - position
	
	
	timer.start()


func _on_Timer_State_timeout():
	timer.stop()
	timer.wait_time = state_time
	lock = false


func _on_Timer_Sound_timeout():
	$Bubble.play()
	timer_sound.wait_time = rand_range(1, 3)

func delete():
	animation_player.play("default")
	

func _on_AnimatedSprite_animation_finished():
	# Delete this boid
	var parent = get_parent()
	if parent != null:
		var type = boidType
#		print('incrementing type ', type)
		Manager.sacrificed_boids += 1
		Manager.update_life_bars()
		queue_free()
	pass # replace with function body
