extends CanvasLayer


func update_lives(sacrificed_boids, total_lives):
	# Reset all icons to visible
	for i in range(total_lives):
		if sacrificed_boids < total_lives:
			get_node("Lives/Grid/Life" + str(i)).visible = i >= sacrificed_boids


func _on_ContinueButton_pressed():
	Manager.continue_level()
