extends Node2D


func _on_Area2D_input_event(viewport, event, shape_idx):
	$Playbutton0.show()
	if Input.is_action_pressed("mouse_leftClick"):
		$playFX.play()
		$transition.play("dissolve")
		
	pass # Replace with function body.s


func _on_Area2D_mouse_exited():
	$Playbutton0.hide()


func _on_playFX_finished():
	get_tree().change_scene("res://scenes/stage_select.tscn")
