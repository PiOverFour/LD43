extends Area2D

enum TYPE { RED, YELLOW, BLUE }
export(TYPE) var totem_type = TYPE.RED

enum STATE { TARGET, GROUP, ALONE, ATTRACTED, REPULSED }

var count = 0
export(int) var valid_number = 1

var valid = false

onready var petale = $petale
onready var sprites = $sprites

func _ready():
	sprites.get_child(1).visible = true

func _process(delta):
	if not valid:
		var overlapping_bodies = get_overlapping_bodies()
		if not overlapping_bodies:
			return
		
		for body in overlapping_bodies:
			if not body.is_in_group("boids"):
				return
			
			if body.boidType != totem_type:
				return
			
			if body.boidState != STATE.ATTRACTED:
				count += 1
#				petale.get_child(count-1).visible = true
				print(get_node("sprites/" + str(count)))
				get_node("./sprites/" + str(count)).visible = false
				get_node("./sprites/" + str(count+1)).visible = true
#				sprites.get_child(count-1).visible = false
#				sprites.get_child(count).visible = true
			
			body.totem_position = position
			body.boidState = STATE.ATTRACTED
		
		if count >= valid_number:
			valid = true