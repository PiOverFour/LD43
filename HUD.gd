extends CanvasLayer


func update_lives(sacrificed_boids, total_lives):
	# Reset all icons to visible
	for i in range(total_lives):
		if sacrificed_boids < total_lives:
#			get_node("Lives/Grid/Life" + str(i)).visible = i >= sacrificed_boids
			if i >= sacrificed_boids:
				get_node("Lives/Grid/Life" + str(i) + "/AnimationPlayer").assigned_animation = "play"
				get_node("Lives/Grid/Life" + str(i) + "/AnimationPlayer").seek(0)
			else:
				get_node("Lives/Grid/Life" + str(i) + "/AnimationPlayer").play("play")


func _on_ContinueButton_pressed():
	Manager.continue_level()


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_PlayButton_pressed():
	Manager.load_level("Level0")
	get_node("/root/Main/Menu/AnimationPlayer").play_backwards("GameOver")


func _on_Continue2Button_pressed():
	get_node("/root/Main/Menu/AnimationPlayer").play_backwards("GameOver")
