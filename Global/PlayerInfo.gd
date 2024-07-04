extends Node

var player : Node2D

func updatePlayer():
	print("updating payer")
	if is_instance_valid(player):
		print("updating saved mana to: " + str(player.getMana()))
		mana = player.getMana()


var mana: float
var health: float
