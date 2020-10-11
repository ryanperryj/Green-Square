extends KinematicBody2D

export(float) var FRICTION = 4000
export(float) var ACCELERATION = 4000
export(float) var MAX_SPEED = 250

enum {MOVE, ATTACK}

var state = MOVE
var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO

onready var stats = $Stats
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	$SwordHitbox/CollisionShape2D.disabled = true
	$SwordParticleSprite.visible = false
	animationTree.active = true
	animationState.start("Idle")

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)

func move_state(delta):
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(MAX_SPEED * input_vector, ACCELERATION * delta)
		self.set_rotation(input_vector.angle() + PI/2)
		if animationState.is_playing():
			animationState.travel("Run")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		if animationState.is_playing():
			animationState.travel("Idle")
	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attack_state(delta):
	if animationState.is_playing():
		animationState.travel("SwordAttack")

func attack_animation_finished():
	state = MOVE

func _on_Hurtbox_area_entered(area):
	stats.health -= 1

func _on_Stats_no_health():
	queue_free()
