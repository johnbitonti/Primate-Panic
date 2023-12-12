extends Node2D
onready var keyLabel = get_node("CanvasLayer/RichTextLabel")
onready var timer = get_node("CanvasLayer/text")
var numOfKeys=0
var pause
var time=0
var time_passed

#timer
func _process(delta):	
	time+=delta
	var mils = fmod(time,1)*1000
	var secs = fmod(time,60)
	var mins = fmod(time,60*60) /60
	time_passed = "%02d:%02d:%03d" % [mins,secs,mils]
	timer.clear()
	timer.add_text("Time: "+time_passed)

#on start
#dont repeat the lava warning message after a death 
func _on_Node2D_ready():
	Global.prevscene = get_tree().current_scene.filename
	$lavaanim.play("rising")
	if(Global.alreadyClicked):
		clearText()
	else:
		get_tree(). paused = true
#key collected	
func _on_keys_key_collected():
	emit_signal("key_collected")
	numOfKeys = numOfKeys+1
	var keyText = "Keys " + String(numOfKeys)+"/6"
	keyLabel.clear()
	keyLabel.add_text(keyText)
#if player touches lava send them to gameover screen
#delete enemy if they touch lava
func _on_lava_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://scenes/gameOver.tscn")
	pass
	if body.is_in_group("enemy"):
		body.queue_free()
#click on play button
func _on_Level1Box_input_event(viewport, event, shape_idx):
	$button1.show()
	if Input.is_action_pressed("mouse_leftClick"):
		$playFX.play()
		clearText()
		Global.alreadyClicked=true

#mouse leaves play button
func _on_Level1Box_mouse_exited():
	$button1.hide()
#clear the warning text
func clearText():
	$Level1Box.queue_free()
	$border.queue_free()
	$button0.queue_free()
	$button1.queue_free()
	get_tree(). paused = false

#if player enters the door with every key the level is complete and save the timer 
func _on_DoorArea_body_entered(body):
	if body.is_in_group("player")and numOfKeys==6:
		Global.curr_level_1_time = time
		get_tree().change_scene("res://scenes/levelComplete.tscn")
		
