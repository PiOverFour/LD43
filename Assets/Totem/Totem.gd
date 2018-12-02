extends Area2D

enum TYPE { RED, YELLOW, BLUE }
export(TYPE) var totem_type = TYPE.RED

enum STATE { TARGET, GROUP, ALONE, ATTRACTED, REPULSED }


func _process(delta):

	var overlapping_bodies = get_overlapping_bodies()
	if not overlapping_bodies:
		return
	
	for body in overlapping_bodies:
		if not body.is_in_group("boids"):
			return
		
		print(body.boidType)
		print(totem_type)
		
		if body.boidType != totem_type:
			return
		
		body.totem_position = position
		body.boidState = STATE.ATTRACTED
