extends Area2D

class_name InteractionAreaComponent 

@export var actionName: String = "interact"
var interlocutor: Node2D # I google a word for "a person whom I am interacting with" lmao

var interactable: bool = true

var interact : Callable = func():
	pass


# Called when the node enters the scene tree for the first time.
func _ready(): 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# if a player enters this will register itself to the global interaction manager
func _on_body_entered(body):
	interlocutor = body
	if body.name == "Player":
		
		InteractionManager.registerArea(self)


func _on_body_exited(body):
	interlocutor = null
	InteractionManager.unregisterArea(self)
