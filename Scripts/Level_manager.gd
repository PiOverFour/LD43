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

onready var timer = Timer.new()

var boid_radius = 800

func _ready():
	# Set up boid instancing
	timer.wait_time = 2 # Spawn interval
	timer.connect("timeout", self, "add_boid")
	timer.autostart = true
	timer.process_mode = timer.TIMER_PROCESS_PHYSICS
#	timer.start()
	add_child(timer)
	
	for i in range(0, boidArray.size()):
		for j in range(1,6):
			print(boidArray[i])
			var path = boids[boidArray[i]] + str(j) + ".tscn"
			print(path)
			boid_nodes.push_back(load(path))
	print(boid_nodes)
#	print(timer.is_stopped())


func add_boid():
#	print("Adding boid...")
	var boid_type = randi() % boid_nodes.size()
	var boid_instance = boid_nodes[boid_type].instance()
	var angle = rand_range(-PI, PI)
	boid_instance.position = Vector2(cos(angle), sin(angle))*boid_radius
#	get_tree().root.add_child(boid_instance)
	get_node("/root/Main").add_child(boid_instance)
	pass