extends Area2D

enum TYPE { RED, YELLOW, BLUE }
export(TYPE) var totem_type = TYPE.RED

enum STATE { TARGET, GROUP, ALONE, ATTRACTED, REPULSED }

var count = 0
export(int) var valid_number = 1

var valid = false

onready var petale = $petale

func _process(delta):

	var overlapping_bodies = get_overlapping_bodies()
	if not overlapping_bodies:
		return
	
	for body in overlapping_bodies:
		if not body.is_in_group("boids"):
			return
		
		if body.boidType != totem_type:
			return
		
		if body.boidState != STATE.ATTRACTED:
			count += 1
			
		
		body.totem_position = position
		body.boidState = STATE.ATTRACTED
	
	if count >= valid_number:
		valid = true