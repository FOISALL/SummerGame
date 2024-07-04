extends Node2D

	

func _physics_process(delta):
	pass
	#if Input.is_action_just_pressed("escape"):
		#get_node("PauseMenu").showAll()
		#get_tree().paused = true

func _input(event):
	if event.is_action_pressed("escape"):
		get_node("PauseMenu").showAll()
		get_tree().paused = true
		get_viewport().set_input_as_handled()


