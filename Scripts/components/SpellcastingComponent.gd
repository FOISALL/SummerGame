extends Node2D

class_name SpellcastingComponent

@export var manaComp : ManaComponent

var learnedSpells: Array[Spell] = []
var preparedSpells: Array[Spell] = []
var activeSpells: Array[Spell] = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# creates a copy of a prepared spell and casts it
func castSpell():
	var spellCopy : Spell
	if !preparedSpells.is_empty():
		print("spell Casts!!")
		# Cast first spell in spell array, logic for this may change in the future
		var spell: Spell = preparedSpells[0]
		print(manaComp.mana)
		if spell.manaCost <= manaComp.mana:
			spellCopy = spell.clone()
			# Add spell to scene tree
			get_tree().get_current_scene().add_child(spellCopy)
			print("spending " + str(spellCopy.manaCost) + " mana out of current "+ str(manaComp.mana) + " mana")
			manaComp.spend(spellCopy.manaCost)
			
			# Add spell to active spells array and cast
			activeSpells.append(spellCopy)
			spellCopy.connect("spellOver",_on_spellOver)
			spellCopy.cast()
		else:
			print("not enough mana")
		
func _on_spellOver(spell: Spell):
	
	var index = activeSpells.find(spell)
	
	if index != -1:
		print("ending spell " + spell.id)
		activeSpells.remove_at(index)
		spell.queue_free()
	 	#owner.remove_sibling(spell)
	


