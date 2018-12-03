extends Sprite

export(float) var speed = 5

func _process(delta):
	rotation_degrees = rotation_degrees + delta * speed
