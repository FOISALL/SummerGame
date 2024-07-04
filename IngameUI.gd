extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Mana/ManaBar").max_value = 1000
	get_node("Health/HealthBar").max_value = 1000

	$Mana.text = ("Mana: " )
	$Mana/ManaBar.value = 30
	Signals.connect("playerManaChanged",_on_Player_mana_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	

	get_node("Health").text = ("Health: " + str(PlayerInfo.health))
	get_node("Health/HealthBar").value = PlayerInfo.health
	pass

	
	
func _on_Player_mana_changed(newValue):
	$Mana.text = ("Mana: " + str(newValue))
	$Mana/ManaBar.value = newValue
