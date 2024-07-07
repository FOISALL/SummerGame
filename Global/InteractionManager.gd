extends Node2D



@onready var player: Node2D # get_tree().get_first_node_in_group("player")
@onready var label = $InteractionPrompt

const BASE_TEXT = "E to "

var activeAreas = []
var canInteract = true

func registerArea(area: InteractionAreaComponent):
	if(area.interactable):
		print("regestering to manager")
		activeAreas.push_back(area)	
		

	
func unregisterArea(area: InteractionAreaComponent):
	
	var index = activeAreas.find(area)
	print("trying to unregister")
	if index != -1:
		print("Unregestering to manager")
		activeAreas.remove_at(index)
		
func _process(delta):
	if activeAreas.size() > 0 && canInteract:
		#print("showing")
		if activeAreas.size() > 1 && canInteract:
			activeAreas.sort_custom(_sortByPlayerDistance)
		label.text = BASE_TEXT + activeAreas[0].actionName
		label.global_position = activeAreas[0].global_position
		label.global_position.y -= 40
		label.global_position.x -= label.size.x /2
		label.show()

	else:

		label.hide()
		
func _sortByPlayerDistance(area1, area2):
	var area1ToPlayer = player.global_position.distance_to(area1.global_position)
	var area2ToPlayer = player.global_position.distance_to(area2.global_position)
	return area1ToPlayer < area2ToPlayer
	
func _input(event):
	if event.is_action_pressed("Interact"):
		if activeAreas.size() > 0:
			canInteract = false
			label.hide()
			
			await activeAreas[0].interact.call()
			
			canInteract = true
	
		
