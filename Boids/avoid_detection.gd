extends Area2D


func _ready():

	pass

func _physics_process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	if not overlapping_bodies:
		return

	for body in overlapping_bodies:
		if not body.is_in_group("boids") and not body.is_in_group("player"):
			return
		if is_owner(body):
			return
		# choose to avoid or not
	
