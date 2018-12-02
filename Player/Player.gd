extends KinematicBody2D

export var VELOCITY = Vector2(300, 300)
var direction = Vector2()

func _ready():
	pass

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		direction = get_local_mouse_position()
		if direction.length_squared() < 5:
			direction.x = 0
			direction.y = 0
		direction = direction.normalized()
		move_and_slide(VELOCITY * direction)
		var child_rot = rad2deg(atan2(direction.y, direction.x)) 
		$target.rotation_degrees = child_rot - 90
		$CollisionShape2D.rotation_degrees = child_rot

#func _unhandled_key_input(event):
#    if event is InputEventKey:
#        if event.pressed:
#            if event.scancode == KEY_LEFT:
#                movement.x = -1
#            if event.scancode == KEY_RIGHT:
#                movement.x = 1
#            if event.scancode == KEY_UP:
#                movement.y = -1
#            if event.scancode == KEY_DOWN:
#                movement.y = 1
