extends Area2D

func _process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.is_in_group("boids"):
			body.delete()
			
