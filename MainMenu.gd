extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# loads saved data using global script
	Utils.loadGame()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# switch to the first scene
func _on_play_pressed():
	print("entering game")
	get_tree().change_scene_to_file("res://demo_world.tscn")





func _on_quit_pressed():
	print("quitting")
	get_tree().quit()
