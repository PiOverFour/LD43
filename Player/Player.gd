extends KinematicBody2D

export var VELOCITY = Vector2(300, 300)
var direction = Vector2()

func _ready():
    pass

func _process(delta):
    direction = get_local_mouse_position()
    if direction.length_squared() < 5:
        direction.x = 0
        direction.y = 0
    direction = direction.normalized()
#    position += velocity * delta * direction
    move_and_slide(VELOCITY * direction)

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
