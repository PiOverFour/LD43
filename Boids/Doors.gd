extends Area2D

enum TYPE { RED, YELLOW, BLUE }
export(TYPE) var doorType = TYPE.RED

var orientation = Vector2(0,0)

func _ready():
	orientation = Vector2(cos(deg2rad(rotation_degrees - 90)), sin(deg2rad(rotation_degrees - 90)))

func _process(delta):
	count = 0
	var overlapping_bodies = get_overlapping_bodies()
	if not overlapping_bodies:
		return
	
	for body in overlapping_bodies:
		if not body.is_in_group("boids"):
			return
		if not body.boidType == doorType:
			return
		body.
