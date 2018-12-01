tool
extends Polygon2D

export var radius = 500# setget radius_set
export var vertices = 32# setget vertices_set

func radius_set(_radius):
	radius = _radius
	create_polygon()

func vertices_set(_vertices):
	vertices = _vertices
	create_polygon()

func create_polygon():
	var poly = PoolVector2Array()
	var x
	var y
	for i in range(vertices):
		x = cos(2*PI * i / vertices) * radius
		y = sin(2*PI * i / vertices) * radius
		poly.append(Vector2(x, y))
	polygon = poly
