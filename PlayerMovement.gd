extends KinematicBody2D

var velocity = Vector2()
var speed 
var movement_able = true
signal clicked
var pingus = "sussy"
onready var twojStary = $AnimationTree.get("parameters/playback")
signal turn
	
func get_input():
	velocity = Vector2()
	var input_vector = Vector2()
	if Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_down"):
		velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right"):
		velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	input_vector.x = velocity.x
	input_vector.y = velocity.y
	if input_vector != Vector2.ZERO:
		$AnimationTree.set("parameters/Idle/blend_position", input_vector)
		$AnimationTree.set("parameters/walking/blend_position", input_vector)
		twojStary.travel("walking")
	else:
		twojStary.travel("Idle")

	if Input.is_action_pressed("running"):
		speed = 350
	else:
		speed = 250
		
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("clicked")
	
func _physics_process(delta):
	
	if movement_able:
		get_input()
		velocity = move_and_slide(velocity.normalized()*speed)
	
func on_dix():
	if movement_able:
		movement_able = false
	else:
		movement_able = true

func get_position():
	return velocity
	
func get_speed():
	return speed
	
func get_AnimPlayer():
	return $AnimationPlayer
	
func get_AnimTree():
	return $AnimationPlayer
