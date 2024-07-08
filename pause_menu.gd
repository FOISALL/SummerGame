extends Node2D


# Called when the node enters the scene tree for the first time.
# starts hidden and is set to only be active when paused
func _ready():
	hideAll()
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		

# unpauses when esc is pressed
func _input(event):
	if event.is_action_pressed("escape"):
		unpause()
		

# unpauses when continue button is pressed
func _on_continue_pressed():
	unpause()
	
# unpause hides the node and resumes the game
func unpause():
	hideAll()
	get_tree().paused = false
	get_viewport().set_input_as_handled()
	

# For some reason the canvas node works differently, when its parent node pause menu in this case is hid
# the canvas node doesn´t copy that state. For this reason it need to be hid manualy
func hideAll():
	hide()
	get_node("Camera2D/CanvasLayer").hide()
	
func showAll():
	show()
	get_node("Camera2D/CanvasLayer").show()



func _on_quit_to_menu_pressed():
	unpause()
	PlayerInfo.updatePlayer()
	
	Utils.saveGame()
	await get_tree().change_scene_to_file("res://MainMenu.tscn")
