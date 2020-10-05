extends KinematicBody2D

onready var stats = $Stats

func _on_Hurtbox_area_entered(area):
	stats.health -= 1

func _on_Stats_no_health():
	queue_free()
