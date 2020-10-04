extends KinematicBody2D

export(float) var FRICTION = 800
export(float) var ACCELERATION = 800
export(float) var MAX_SPEED = 50

var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true
	animationState.start("Idle")

func _physics_process(delta):
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(MAX_SPEED * input_vector, ACCELERATION * delta)
		
		if input_vector.x == 0:
			self.set_rotation(input_vector.sign().y*PI/2 + PI/2)
		else:
			self.set_rotation(input_vector.sign().x*PI/2)
			
		
		if animationState.is_playing():
			animationState.travel("Run")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		if animationState.is_playing():
			animationState.travel("Idle")
	
	velocity = move_and_slide(velocity)
