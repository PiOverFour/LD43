extends Node2D

export(Array) var boidArray = Array()
var boid_nodes = Array()

enum BOID_TYPES { RED, YELLOW, BLUE }

const boids = {
	"RED": "res://Boids/Red/",
	"YELLOW": "res://Boids/Yellow/",
	"BLUE": "res://Boids/Blue/",
	}

export(Array) var totemArray = Array()

export var bounds = 1000
export var boid_radius = 800
export(String) var next_level

export(float) var spawn_interval = 3

onready var timer = Timer.new()
onready var win_timer = Timer.new()
export var win_time = 4

onready var player = get_node("../Player")
onready var camera = get_node("../Player/Camera2D")

export(float) var dezoom = 2

var valid = false
var victory = false
var t = 0

func _ready():
	# Set up boid instancing
	timer.wait_time = spawn_interval # Spawn interval
	timer.connect("timeout", self, "add_boid")
	timer.autostart = true
	timer.process_mode = timer.TIMER_PROCESS_PHYSICS
#	timer.start()
	add_child(timer)
	
	win_timer.wait_time = win_time
	win_timer.connect("timeout", self, "win")
	win_timer.autostart = false
	win_timer.process_mode = win_timer.TIMER_PROCESS_PHYSICS
	add_child(win_timer)
	
	for i in range(0, boidArray.size()):
		for j in range(1,6):
			var path = boids[boidArray[i]] + str(j) + ".tscn"
			boid_nodes.push_back(load(path))
#	print(boid_nodes)
#	print(timer.is_stopped())


func _process(delta):
	
	if not valid:
		for totem in totemArray:
			valid = true
			if get_node(totem).valid == false:
				valid = false
	else:
		if not victory:
			victory = true
			var pit = $Pit
			
			pit.queue_free()
			win_timer.start()
		# win
		player.position = player.position.linear_interpolate(Vector2(0,0), min(t, 1))
		camera.zoom = camera.zoom.linear_interpolate(Vector2(2.7,2.7), min(t, 1))
		camera.limit_left = -10000
		camera.limit_top = -10000
		camera.limit_right = 10000
		camera.limit_bottom = 10000
		camera.drag_margin_h_enabled = false
		camera.drag_margin_v_enabled = false
		t += delta / 5
		

func win():
	Manager.load_level(next_level)

func add_boid():
#	print("Adding boid...")
	var boid_type = randi() % boid_nodes.size()
	var boid_instance = boid_nodes[boid_type].instance()
	var angle = rand_range(-PI, PI)
	boid_instance.position = Vector2(cos(angle), sin(angle))*boid_radius
#	get_tree().root.add_child(boid_instance)
	add_child(boid_instance)
	pass