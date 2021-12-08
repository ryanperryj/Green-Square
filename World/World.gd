extends Node2D

func _ready():
	var sz_ch = 3
	var tl_types = []
	var x = 0
	var y = 0
	while x < sz_ch:
		tl_types.append([])
		y = 0
		while y < sz_ch:
			tl_types[x].append(-1)
			y += 1
		x += 1
	
	print(tl_types)

func _process(delta):
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("close"):
		get_tree().quit()
