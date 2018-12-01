extends Node2D

func _ready():
	Manager.set_target($Camera2D)

func _process(delta):
	pass
#	print(manager.target)