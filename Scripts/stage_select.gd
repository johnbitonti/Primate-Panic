extends Node2D
var tutorial := false
var level1 := false
var level2:= false
var credits := false
onready var level_1_best = get_node("level_1_best_time")
onready var level_2_best = get_node("level_2_best_time")


#function to bring to the next selected screen
func _on_playFX_finished():
	if(tutorial):
		get_tree().change_scene("res://Scenes/tutorial.tscn")
	if(level1):
		get_tree().change_scene("res://Scenes/level_1.tscn")
	if(level2):
		get_tree().change_scene("res://Scenes/level_2.tscn")
	if(credits):
		get_tree().change_scene("res://scenes/credits.tscn")
func _on_Node2D_ready():
	$transition.play("fadein")
	Global.alreadyClicked=false
	
	if(Global.best_level_1_time!=99999):
		level_1_best.clear()
		level_1_best.add_text("Best Time: "+ Global.convertDeltaToTime(Global.best_level_1_time))
	if(Global.best_level_2_time!=99999):
		level_2_best.clear()
		level_2_best.add_text("Best Time: "+ Global.convertDeltaToTime(Global.best_level_2_time))
#Bring to credits
func _on_RichTextLabel_gui_input(event):
	$ColorRect.show()
	if Input.is_action_pressed("mouse_leftClick"):
		credits=true
		$playFX.play()
		$transition.play("dissolve")
func _on_RichTextLabel_mouse_exited():
	$ColorRect.hide()		

#Bring to tutorial level
func _on_TutorialBox_input_event(viewport, event, shape_idx):
	$Playbutton0.show()
	if Input.is_action_pressed("mouse_leftClick"):
		tutorial=true
		$playFX.play()
		$transition.play("dissolve")
func _on_TutorialBox_mouse_exited():
	$Playbutton0.hide()
	
#bring to level 1
func _on_Level1Box_input_event(viewport, event, shape_idx):
		$Level1Button1.show()
		if Input.is_action_pressed("mouse_leftClick"):
			level1=true
			$playFX.play()
			$transition.play("dissolve")
		
func _on_Level1Box_mouse_exited():
	$Level1Button1.hide()


func _on_Level2Box_mouse_exited():
	$Level2Button1.hide()


func _on_Level2Box_input_event(viewport, event, shape_idx):
	$Level2Button1.show()
	if Input.is_action_pressed("mouse_leftClick"):
			level2=true
			$playFX.play()
			$transition.play("dissolve")
	
