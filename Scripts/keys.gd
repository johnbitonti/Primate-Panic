extends Area2D

signal key_collected
onready var keyLabel = get_node("CanvasLayer/RichTextLabel")
func _on_keys_body_entered(body):
	if body.is_in_group("player"):
		$KeyCollectFX.play()
		emit_signal("key_collected")
		$CollisionShape2D.queue_free()
		hide()
	pass # Replace with function body.
