extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Mana/ManaBar").max_value = 1000
	get_node("Health/HealthBar").max_value = 100
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Mana").text = ("Mana: " + str(PlayerInfo.mana))
	get_node("Mana/ManaBar").value = PlayerInfo.mana
	
	
	get_node("Health").text = ("Health: " + str(PlayerInfo.health))
	get_node("Health/HealthBar").value = PlayerInfo.health
	pass
