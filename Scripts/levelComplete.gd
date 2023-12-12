extends Node2D


onready var timer = get_node("text")



func _on_music_finished():
	$transition.play("dissolve")




func _on_transition_animation_finished(anim_name):
	get_tree().change_scene("res://Scenes/stage_select.tscn")


func _on_Node2D_ready():

	if(Global.prevscene=="res://Scenes/level_1.tscn"):
		timer.clear()
		timer.add_text("Time: "+ Global.convertDeltaToTime(Global.curr_level_1_time))
		if( Global.curr_level_1_time < Global.best_level_1_time):
			Global.best_level_1_time = Global.curr_level_1_time
			
	if(Global.prevscene=="res://Scenes/level_2.tscn"):
		timer.clear()
		timer.add_text("Time: "+ Global.convertDeltaToTime(Global.curr_level_2_time))
		if( Global.curr_level_2_time < Global.best_level_2_time):
			Global.best_level_2_time = Global.curr_level_2_time
