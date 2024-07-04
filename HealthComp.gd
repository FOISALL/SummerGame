extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 100
var health : int

func _ready():
	health = MAX_HEALTH 
	


func damage(attack: Attack):
	
	health -= attack.attackDamage
	var parent = get_parent()
	
	parent.velocity = (global_position - attack.attackPos).normalized()*attack.knockback
	
	if health <= 0:
		parent.queue_free()
	
	
