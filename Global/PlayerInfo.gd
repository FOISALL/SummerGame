extends Node

var player : Node2D

# updates values based on player before save is performed
func updatePlayer():
	
	if is_instance_valid(player):
		print("updating payer")
		mana = player.getMana()
		health = player.getHealth()
		


var mana: float
var health: float
