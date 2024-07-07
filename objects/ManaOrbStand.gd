extends RigidBody2D

var active = true
var interactionArea : InteractionAreaComponent 



# Called when the node enters the scene tree for the first time.
func _ready():
	interactionArea = $InteractionAreaComponent
	if (interactionArea == null):
		print("null")
	interactionArea.interact = Callable(self, "_onInteract")
	
func _onInteract():
	print("ready to interact")
	if ("manaPool" in interactionArea.interlocutor) && (interactionArea.interlocutor.manaPool) is ManaComponent:
		interactionArea.interlocutor.manaPool.restore(300)
	active = false
	$InteractionAreaComponent.hide()
	$InteractionAreaComponent.interactable = active
	InteractionManager.unregisterArea($InteractionAreaComponent)
	$SpriteActive.hide()
	$SpriteInactive.show()
	$Timer.start()
	
	
func _on_timer_timeout():
	active = true
	$InteractionAreaComponent.interactable = active
	$InteractionAreaComponent.show()
	if ($InteractionAreaComponent.interlocutor.name == "Player"):
		$InteractionAreaComponent._on_body_entered($InteractionAreaComponent.interlocutor)
	$SpriteActive.show()
	$SpriteInactive.hide()
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



