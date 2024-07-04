extends Node2D
class_name ManaComponent

signal manaChanged(newMana) 

@export var MAX_MANA := 1000
@export var mana : float
@export var regen: float

func _ready():
	mana = MAX_MANA 
	


# for casting spells
func spend(cost: float):
	_setMana(max(0,mana - cost))

# for regeneration and other restoration methods
func restore(amount: float):
	_setMana(min(MAX_MANA, mana + amount))
	
# main method for changing mana, not meant to be called from outside, emits signal for parent
func _setMana(newMana):
	mana = newMana
	emit_signal("manaChanged",mana)
	
func isFull():
	return MAX_MANA == mana

func isEmpty():
	return mana == 0
	
	

func _on_regen_timer_timeout():
	restore(regen * $RegenTimer.wait_time)
