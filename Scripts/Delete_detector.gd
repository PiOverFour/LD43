extends Area2D

func _process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.is_in_group("boids"):
			delete(body)

func delete(boid):
	# Delete this boid
	boid.get_parent().remove_child(boid)
	var type = boid.boidType
	print('incrementing type ', type)
	Manager.sacrificed_boids[Manager.boid_names[type]] += 1
	Manager.update_life_bars()