extends Node2D

export var velocity = Vector2(10, 10)
var movement = Vector2()

func _ready():
    pass

func _process(delta):
    position += velocity * delta * movement

func _unhandled_key_input(event):
    if event is InputEventKey:
        if event.pressed:
            if event.scancode == KEY_LEFT:
                movement.x = -1
            if event.scancode == KEY_RIGHT:
                movement.x = 1
            if event.scancode == KEY_UP:
                movement.y = -1
            if event.scancode == KEY_DOWN:
                movement.y = 1
