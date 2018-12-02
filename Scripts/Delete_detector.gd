extends Area2D

func _process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.is_in_group("boids"):
			delete(body)

func delete(boid):
	# Delete this boid
	if boid != null and boid.get_parent() != null:
		var type = boid.boidType
		print('incrementing type ', type)
		Manager.sacrificed_boids += 1
		Manager.update_life_bars()
		boid.get_parent().remove_child(boid)
		boid.queue_free()
