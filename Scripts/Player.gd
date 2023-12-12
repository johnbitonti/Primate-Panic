extends KinematicBody2D

var on_vine := false
var climbing_vine:=false
var jumping :=false
var climbFX_has_played:=false
	

onready var _animated_sprite = $AnimatedSprite
onready var _player_collision = $player_collision
#Walking animation

#controls and physics
var velocity = Vector2.ZERO
func _physics_process(delta):
	
	var input = Vector2.ZERO
	input.x= Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y= Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	apply_gravity()
	#if the player presses left or right the character will move and animation will play
	#moving left
	if(input.x<0):
		_animated_sprite.flip_h=true
		#if running
		_animated_sprite.speed_scale = 1.0
		if(jumping==false):
			_animated_sprite.play("walk")
		apply_acceleration(input.x)
	#moving right
	if(input.x>0):
		_animated_sprite.flip_h=false
		_animated_sprite.speed_scale = 1.0
		if(jumping==false):
			_animated_sprite.play("walk")
		apply_acceleration(input.x)
		#return to idle and apply friction when no direction is pressed
	if(input.x==0 and climbing_vine==false and jumping==false):
		apply_friction()
		_animated_sprite.play("idle")
			
	#if player touching a vine
	if(on_vine):
		#player presses up on vin
		if(input.y>0):		
			climbing_vine=true
			_animated_sprite.play("climb")
			velocity.y=-110
			
		#presses down on vine
		elif(input.y<0):
			
			climbing_vine=true
			_animated_sprite.play("climb")
			velocity.y=110
		elif(climbing_vine==true):
			velocity.y=0
			_animated_sprite.play("idle_climb")
	else:
		climbing_vine=false
	#climbing sound effects
	if climbing_vine and velocity.y!=0:
		if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
			if(!climbFX_has_played):
				$climbFX.play()
				climbFX_has_played=true
	else:
		climbFX_has_played=false
		$climbFX.stop()
		
	#jump soundFX
	if(velocity.y>0 or climbing_vine==true):
		$jumpFX.stop()		
		
	#jumping code 
	if is_on_floor():
		#cancel jump animation
		jumping=false
		if Input.is_action_just_pressed("ui_select"):
			jumping=true
			$jumpFX.play()	
			velocity.y=-170
			
	else:	
		if Input.is_action_just_released("ui_select") and velocity.y < -64 :	
			velocity.y=-70
		if velocity.y >10:
			velocity.y+=4 
	#play jump animation		
	if jumping and climbing_vine==false:
		_animated_sprite.play("jump")
	velocity = move_and_slide(velocity, Vector2.UP)
	

		
func apply_gravity():
	velocity.y+=4
	
func apply_friction():
	velocity.x=move_toward(velocity.x,0,10)
	
func apply_acceleration(amount):
	velocity.x= move_toward(velocity.x, 140*amount, 10)
	pass
#on vine checker
func _on_Area2D_body_entered(body):
	on_vine = true
	pass 
func _on_Area2D_body_exited(body):
	on_vine = false
	pass # Replace with function body.
	
func _on_fallzone_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://scenes/gameOver.tscn")
	pass 

func _on_spikezone_body_entered(body: Node2D)-> void:
	if body.is_in_group("player"):	
		get_tree().change_scene("res://scenes/gameOver.tscn")
	pass # Replace with function body.

func _on_secret_body_entered(body):
	if body.is_in_group("player"):
		$"Main Theme".stop()
		$enemyanimation.show()
		$AnimatedSprite.hide()
		$"secret".play()
