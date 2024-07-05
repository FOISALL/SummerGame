extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Mana/ManaBar").max_value = 1000
	$Mana.text = ("Mana: " )
	$Mana/ManaBar.value = PlayerInfo.mana
	Signals.connect("playerManaChanged",_on_Player_mana_changed)
	
	
	$Health.text = "Health: " + str(PlayerInfo.health)
	$Health/HealthBar.max_value = 200
	$Health/HealthBar.value = PlayerInfo.health
	Signals.connect("playerHealthChanged",_on_Player_health_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
	
func _on_Player_mana_changed(newValue):
	$Mana.text = ("Mana: " + str(int(newValue))) # this is not proper rounding, fix later
	$Mana/ManaBar.value = newValue
	
func _on_Player_health_changed(newValue):
	$Health.text = ("Health: " + str(int(newValue))) # this is not proper rounding, fix later
	$Health/HealthBar.value = newValue
