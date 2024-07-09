extends Node2D
class_name HealthComponent

signal healthChanged(health)

var MAX_HEALTH : float
var health : float
var regen : float
var full : bool 

func _ready():
	health = MAX_HEALTH 
	


func damage(attack: Attack):
	
	lose(attack.attackDamage)
	var parent = get_parent()
	
	parent.velocity = (global_position - attack.attackPos).normalized()*attack.knockback
	
	if health <= 0:
		parent.queue_free() 
		# here it might be good to insteade have a callable variable as a function that can be overridden by parent
	
func lose(amount: float):
	_setHealth(max(0,health - amount))

# for regeneration and other restoration methods
func restore(amount: float):
	_setHealth(min(MAX_HEALTH, health + amount))
	
# main method for changing mana, not meant to be called from outside, emits signal for parent
func _setHealth(newHealth):
	var prevHealth = health

	if isFull() && newHealth < prevHealth:

		$HRegenTimer.start()
	elif !isFull() && newHealth == MAX_HEALTH: 
		$HRegenTimer.stop()
	health = newHealth
	emit_signal("healthChanged",prevHealth,health)
	
func isFull():
	return MAX_HEALTH == health

func isEmpty():
	return health == 0


func _on_h_regen_timer_timeout():
	restore(regen * $HRegenTimer.wait_time)
