extends Node2D

onready var respawnBackground = $respawnBackground
onready var quitBackground = $quitBackground


#go back to beginning of current level
func _on_respawn_input_event(viewport, event, shape_idx):
	respawnBackground.show()
	if Input.is_action_pressed("mouse_leftClick"):
		get_tree().change_scene(Global.prevscene)

#return to stage select
func _on_quit_input_event(viewport, event, shape_idx):
	quitBackground.show()
	if Input.is_action_pressed("mouse_leftClick"):
		get_tree().change_scene("res://Scenes/stage_select.tscn")


func _on_quit_mouse_exited():
	quitBackground.hide()


func _on_respawn_mouse_exited():
	respawnBackground.hide()



func _on_gameOver_ready():
	$AnimationPlayer.play("New Anim")
