extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_interaction_area_component_area_entered(area):
	#$InteractionAreaComponent.interacionPrompt.show()
	
	$SpriteActive.show()
	$SpriteInactive.hide()


func _on_interaction_area_component_area_exited(area):
	#$InteractionAreaComponent.interacionPrompt.hide()
	
	$SpriteActive.hide()
	$SpriteInactive.show()
