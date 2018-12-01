extends Area2D

var average_heading = Vector2(0,0)
var group_position = Vector2(0,0)
var count = 0

func _process(delta):
	count = 0
	average_heading = Vector2(0, 0)
	group_position = Vector2(0, 0)
	var overlapping_bodies = get_overlapping_bodies()
	if not overlapping_bodies:
		return
	
	for body in overlapping_bodies:
		if not body.is_in_group("boids"):
			return
#		print(body)
		group_position += body.position
		average_heading += body.heading
		count += 1
	if count > 0:
		group_position = group_position / count
		average_heading = average_heading / count
