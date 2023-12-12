extends KinematicBody2D

var movement = Vector2()
var speed=30
var turnAround=0
var playerInRange:=false

const GRAVITY=32
const UP = Vector2.UP

func _physics_process(delta):
	move()
	
func move():
	if(playerInRange):
		movement.y+=GRAVITY
		if(turnAround%2==0):
			movement.x = -speed
		else:
			movement.x = speed
		
		movement = move_and_slide(movement, UP)


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		playerInRange=true
	pass # Replace with function body.

func _on_enemywalkingbounds_body_entered(body):
	if body.is_in_group("enemy"):
		turnAround=turnAround+1

func _on_hitbox_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://SCENES/gameOver.tscn")


