extends Node2D

class_name StatusEffectComponent

var immunity: Array[StatusEffect] = []
var activeEffects: Array[StatusEffect] = []

@export var healthComp : HealthComponent
@export var manaComp : ManaComponent
@export var movementComp : MovementComponent


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func applyEffect(effect : StatusEffect):
	var effectCopy : StatusEffect
	if !(effect in immunity):
		if effect in activeEffects:
			print("refresh effect")
			refresh(effect)
		else:
			print("applies new effect")
			effectCopy = effect.clone()
			add_child(effectCopy)
			
			activeEffects.append(effectCopy)
			
			effectCopy.setHealthComp(healthComp)
			effectCopy.setManaComp(manaComp)
			effectCopy.setMovementComp(movementComp)
			
			effectCopy.connect("effectOver",_on_effectOver)
			
			effectCopy.activate()
	else:
		print("Immune")
			
func refresh(effect: StatusEffect):
	var index = activeEffects.find(effect)
	# Refresh and overwrite rules will be described seperately for every effect in their refresh function
	activeEffects[index].refresh(effect)

func _on_effectOver(effect: StatusEffect):
	print("catching effect over signal")
	endEffect(effect)


func endEffect(effect: StatusEffect):
	var index = activeEffects.find(effect)
	
	if index != -1:
		print("ending effect" + effect.id)
		activeEffects.remove_at(index)
		effect.queue_free()
