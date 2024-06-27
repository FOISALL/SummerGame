extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	hideAll()
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		

func _input(event):
	if event.is_action_pressed("escape"):
		unpause()
		


func _on_continue_pressed():
	unpause()
	
func unpause():
	hideAll()
	get_tree().paused = false
	get_viewport().set_input_as_handled()
	

func hideAll():
	hide()
	get_node("Camera2D/CanvasLayer").hide()
	
func showAll():
	show()
	get_node("Camera2D/CanvasLayer").show()


func _on_quit_to_manu_pressed():
	Utils.saveGame()
	unpause()
	get_tree().change_scene_to_file("res://MainMenu.tscn")
