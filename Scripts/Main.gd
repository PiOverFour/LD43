extends Node2D

func _ready():
	manager.set_target($Camera2D)

func _process(delta):
	pass
#	print(manager.target)