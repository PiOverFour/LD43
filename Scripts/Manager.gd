extends Node

const LEVELS = {
	"Level0": preload("res://Levels/Level0.tscn"),
	"Level1": preload("res://Levels/Level1.tscn"),
	"Level2": preload("res://Levels/Level2.tscn"),
	"Menu": preload("res://Menu.tscn"),
	}

enum BOID_TYPES { RED, YELLOW, BLUE }

var sacrificed_boids = 0

var BOID_LIVES = 10

var menu = true
var in_game = false

var fade = false
var end = false

func _ready():
	randomize()

func _input(event):
	if event.is_action_pressed("menu"):
		toggle_menu()
	
func toggle_menu():
	if in_game:
		if menu:
			var current_animation_position = get_node("/root/Main/Menu/AnimationPlayer").current_animation_position
			get_node("/root/Main/Menu/AnimationPlayer").play_backwards("GameOver")
			get_node("/root/Main/Menu/AnimationPlayer").seek(current_animation_position)
		else:
			get_node("/root/Main/Menu/AnimationPlayer").play("GameOver")
#			get_node("/root/Main").set_process(false)
		menu = !menu


func update_life_bars():
	if sacrificed_boids == BOID_LIVES:
		game_over()
	get_node("/root/Main/HUD").update_lives(sacrificed_boids, BOID_LIVES)

func game_over():
	get_node("/root/Main/Defeat/GameOver").visible = true
	get_node("/root/Main/Defeat/AnimationPlayer").play("GameOver")

func continue_level():
	load_level(get_node("/root/Main/").get_children()[0].name, false)
	get_node("/root/Main/Defeat/AnimationPlayer").play_backwards("GameOver")
	get_node("/root/Main/Defeat/GameOver").visible = false

func load_level(level, fade=true):
	reset_level()
	setup_new_level(level)
	if fade:
		toggle_fader()
	if end:
		toggle_end()
		end = !end

func reset_level():
	# Reset sacrifices
	sacrificed_boids = 0
	update_life_bars()

func setup_new_level(level):
	# Remove level if present
	for child in get_node("/root/Main").get_children():
		if child.name.begins_with("Level"):
			get_node("/root/Main").remove_child(child)
			child.queue_free()

	# End Game
	if level == "Menu":
		toggle_menu()
		in_game = false
		return

	# Load new level
	var level_scene = LEVELS[level].instance()
	get_node("/root/Main").add_child(level_scene)
	get_node("/root/Main").move_child(level_scene, 0)
	
	# Setup camera
	if "bounds" in level_scene:
		var bounds = level_scene.bounds
		var camera = get_node("/root/Main/Player/Camera2D")
		camera.limit_left = -bounds
		camera.limit_top = -bounds
		camera.limit_right = bounds
		camera.limit_bottom = bounds
		camera.zoom = Vector2(1.5, 1.5)
		camera.drag_margin_h_enabled = false
		camera.drag_margin_v_enabled = false

func toggle_fader():
	if fade:
		get_node("/root/Main/Fader/fader/AnimationPlayer").play("fade")
	else:
		get_node("/root/Main/Fader/fader/AnimationPlayer").play_backwards("fade")
#			get_node("/root/Main").set_process(false)
	fade = !fade

func toggle_end():
	if !end:
		get_node("/root/Main/End/AnimationPlayer").play("GameOver")
	else:
		get_node("/root/Main/End/AnimationPlayer").play_backwards("GameOver")
#			get_node("/root/Main").set_process(false)
