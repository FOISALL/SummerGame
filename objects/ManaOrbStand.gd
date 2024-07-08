extends RigidBody2D

var active = true

# Attached components
var interactionArea : InteractionAreaComponent 



# Called when the node enters the scene tree for the first time.
func _ready():
	interactionArea = $InteractionAreaComponent

	# Assign the function _onInteract to the interaction aresa interact variable
	# Callable varaibles is a variable that holds a function instead of a value
	interactionArea.interact = Callable(self, "_onInteract")
	
func _onInteract():
	print("ready to interact")
	
	# if the one interacting has a manapool the will restore 300 mana and disable the object for some time
	# Ideally you should not even have the option to interact when not eligeble but that can be implemented later
	if ("manaPool" in interactionArea.interlocutor) && (interactionArea.interlocutor.manaPool) is ManaComponent:
		interactionArea.interlocutor.manaPool.restore(300)
		active = false
		$InteractionAreaComponent.hide()
		$InteractionAreaComponent.interactable = active
		InteractionManager.unregisterArea($InteractionAreaComponent)
		$SpriteActive.hide()
		$SpriteInactive.show()
		$Timer.start()
	
	
# Timer to reactivate object after some time
func _on_timer_timeout():
	active = true
	$InteractionAreaComponent.interactable = active
	$InteractionAreaComponent.show()
	$SpriteActive.show()
	$SpriteInactive.hide()
	
	# If player is still standing in area this will reregister them
	if ($InteractionAreaComponent.interlocutor != null &&
	$InteractionAreaComponent.interlocutor.name == "Player"):
		$InteractionAreaComponent._on_body_entered($InteractionAreaComponent.interlocutor)

	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



