extends KinematicBody2D

export(float) var FRICTION = 600
export(float) var ACCELERATION = 800
export(float) var MAX_SPEED = 80

var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO

func _physics_process(delta):
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(MAX_SPEED * input_vector, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)
