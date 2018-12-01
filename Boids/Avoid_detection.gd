extends Area2D

var avoid_position = Vector2(0,0)

func _process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	if not overlapping_bodies:
		return
		
	var n = 0
	avoid_position = Vector2(0, 0)
	for body in overlapping_bodies:
		if not body.is_in_group("boids") and not body.is_in_group("player"):
			return
		avoid_position += body.position
		n += 1
	if n > 0:
		avoid_position = avoid_position / n
