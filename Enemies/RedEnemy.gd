extends KinematicBody2D

onready var stats = $Stats
onready var timer = $Timer
onready var playerDetectionZone = $PlayerDetectionZone
onready var animationPlayer = $AnimationPlayer

enum {IDLE, CHASE}

var state = IDLE
export var JUMP_SPEED = 250
var direction = Vector2.ZERO
var jumping = false

func _physics_process(delta):
	match state:
		IDLE:
			if playerDetectionZone.can_see_player():
				state = CHASE
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				if !animationPlayer.is_playing():
					direction = global_position.direction_to(player.global_position)
					self.set_rotation(direction.angle() + PI/2)
				if timer.time_left == 0:
					animationPlayer.play("Jump")
					move_and_slide(JUMP_SPEED*direction)
			else:
				state = IDLE

func _on_Hurtbox_area_entered(area):
	stats.health -= 1

func _on_Stats_no_health():
	queue_free()

func _on_AnimationPlayer_animation_finished(anim_name):
	timer.start(1)
