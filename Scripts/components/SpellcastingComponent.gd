extends Node2D

class_name SpellcastingComponent

@export var manaComp : ManaComponent

var learnedSpells: Array[Spell] = []
var preparedSpells: Array[Spell] = []
var activeSpells: Array[Spell] = []
# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("spellOver",_on_spellOver)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func castSpell():
	if !preparedSpells.is_empty():
		print("spell Casts!!")
		var spell: Spell = preparedSpells[0]
		if spell.manaCost <= manaComp.mana:
			add_child(spell)
			manaComp.spend(spell.manaCost)
			print("spending " + str(spell.manaCost) + " mana")
			activeSpells.append(spell)
			spell.cast()
		else:
			print("not enough mana")
		
func _on_spellOver(spell: Spell):
	var index = activeSpells.find(spell)
	
	if index != -1:
		activeSpells.remove_at(index)
		remove_child(spell)
	


