extends Node2D



@onready var player: Node2D # might change to a player class when/if that is added
@onready var label = $InteractionPrompt

const BASE_TEXT = "E to "

var activeAreas = [] # Array for all nearby interaction areas
var canInteract = true

# add new area to nearby interaction areas
func registerArea(area: InteractionAreaComponent):
	if(area.interactable):
		print("regestering to manager")
		activeAreas.push_back(area)	
		

# Unregister when no one is near the interaction area
func unregisterArea(area: InteractionAreaComponent):
	
	# Find the index of the area, if it doesnt exist, find() returns -1, 
	# else we get the correct index and can remove the element
	var index = activeAreas.find(area)
	print("trying to unregister")
	if index != -1:
		print("Unregestering to manager")
		activeAreas.remove_at(index)
		
func _process(delta):
	
	# if we have a close interaction area we show the interaction prompt
	if activeAreas.size() > 0 && canInteract:
		
		# In the case where we are in the vicinity of more than 1 area. we must sort the list
		# This will let ud find the closest one and only display the prompt for that one
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
	
	
# when interaction using the interact button no other interaction can take place
func _input(event):
	if event.is_action_pressed("Interact"):
		if activeAreas.size() > 0:
			canInteract = false
			label.hide()
			
			await activeAreas[0].interact.call()
			
			canInteract = true
	
		
