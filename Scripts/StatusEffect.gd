extends Node2D
class_name StatusEffect

enum EffectType {BUFF,DEBUFF}

var id : String
var effect_type : EffectType
var source : Node2D
var target : Node2D

var MAX_LVL : int
var lvl : int

signal effectOver(effect: StatusEffect)

static func new_effect(id: String,source: Node2D, target: Node2D, lvl : int):
	var status_name = id
	var effectPath = load("res://Effects/" + status_name + "/" + status_name +".tscn")
	var effect = effectPath.instantiate()
	effect.source = source
	effect.target = target
	effect.lvl = lvl
	return effect

func clone():
	var clone : StatusEffect = self.duplicate()
	clone.id = self.id
	clone.source = self.source
	clone.target = self.target
	clone.lvl = self.lvl
	return clone
	
func refresh(effect : StatusEffect):
	source = effect.source

# methods to be overridden by children
func activate():
	pass
	
func setHealthComp(healthComp: HealthComponent):
	pass
	
func setManaComp(manaComp: ManaComponent):
	pass

func setMovementComp(moveComp: MovementComponent):
	pass
