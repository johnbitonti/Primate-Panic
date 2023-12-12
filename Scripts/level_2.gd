extends Node2D
onready var keyLabel = get_node("CanvasLayer/RichTextLabel")
onready var timer = get_node("CanvasLayer/text")
var numOfKeys=0
var time = 0
var time_passed
func _process(delta):	
	time+=delta
	var mils = fmod(time,1)*1000
	var secs = fmod(time,60)
	var mins = fmod(time,60*60) /60
	time_passed = "%02d:%02d:%03d" % [mins,secs,mils]
	timer.clear()
	timer.add_text("Time: "+time_passed)
	
func _on_Node2D_ready():
	Global.prevscene = get_tree().current_scene.filename
	$lavaanim.play("rising")
		
func _on_keys_key_collected():
	emit_signal("key_collected")
	numOfKeys = numOfKeys+1
	var keyText = "Keys " + String(numOfKeys)+"/6"
	keyLabel.clear()
	keyLabel.add_text(keyText)

func _on_lava_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://scenes/gameOver.tscn")
	if body.is_in_group("enemy"):
		body.queue_free()
func _on_DoorArea_body_entered(body):
	if body.is_in_group("player") and numOfKeys==6:
		Global.curr_level_2_time = time
		get_tree().change_scene("res://scenes/levelComplete.tscn")
		
