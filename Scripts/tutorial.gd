extends Node2D

var numOfKeys = 0

onready var keyLabel = get_node("CanvasLayer/RichTextLabel")

#set prev scene to return to in case of game over
func _ready():
	Global.prevscene = get_tree().current_scene.filename
	
	
	
	
func _on_keys_key_collected():
	emit_signal("key_collected")
	numOfKeys = numOfKeys+1
	var keyText = "Keys " + String(numOfKeys)+"/1"
	keyLabel.clear()
	keyLabel.add_text(keyText)




func _on_textoff1_body_entered(body):
	$textanim.play("dissolve")
	
func _on_textoff2_body_entered(body):
	$textanim2.play("dissolve")

func _on_textoff3_body_entered(body):
	$textanim3.play("dissolve")

func _on_textoff4_body_entered(body):
	$textanim4.play("dissolve")


func _on_textoff5_body_entered(body):
	$textanim5.play("dissolve")


func _on_textoff6_body_entered(body):
	$textanim6.play("dissolve")


func _on_textanim_animation_finished(anim_name):
	$textanim.queue_free()


func _on_textanim2_animation_finished(anim_name):
	$textanim2.queue_free()


func _on_textanim3_animation_finished(anim_name):
	$textanim3.queue_free()


func _on_textanim4_animation_finished(anim_name):
	$textanim4.queue_free()


func _on_textanim5_animation_finished(anim_name):
	$textanim5.queue_free()


func _on_textanim6_animation_finished(anim_name):
	$textanim6.queue_free()


func _on_fallzone_body_entered(body):
	pass # Replace with function body.


func _on_DoorArea_body_entered(body):
	if(numOfKeys==1):
		get_tree().change_scene("res://scenes/levelComplete.tscn")
