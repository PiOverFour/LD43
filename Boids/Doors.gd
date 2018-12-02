extends Area2D

var count = 0

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
		if not body.type = :
			return
		group_position += body.position
		average_heading += body.heading
		speed += body.speed
		count += 1
	if count > 0:
		group_position = group_position / count
		average_heading = average_heading / count
		speed = speed / count
