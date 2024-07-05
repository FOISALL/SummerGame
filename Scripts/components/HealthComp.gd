extends Node2D
class_name HealthComponent

signal healthChanged(health)

@export var MAX_HEALTH : float
var health : float
@export var regen : float

func _ready():
	health = MAX_HEALTH 
	


func damage(attack: Attack):
	
	health -= attack.attackDamage
	var parent = get_parent()
	
	parent.velocity = (global_position - attack.attackPos).normalized()*attack.knockback
	
	if health <= 0:
		parent.queue_free()
	
func lose(amount: float):
	_setHealth(max(0,health - amount))

# for regeneration and other restoration methods
func restore(amount: float):
	_setHealth(min(MAX_HEALTH, health + amount))
	
# main method for changing mana, not meant to be called from outside, emits signal for parent
func _setHealth(newHealth):
	health = newHealth
	emit_signal("healthChanged",health)
	
func isFull():
	return MAX_HEALTH == health

func isEmpty():
	return health == 0


func _on_h_regen_timer_timeout():
	restore(regen * $HRegenTimer.wait_time)
