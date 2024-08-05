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
	var spellCopy : Spell
	if !preparedSpells.is_empty():
		print("spell Casts!!")
		var spell: Spell = preparedSpells[0]
		print(manaComp.mana)
		if spell.manaCost <= manaComp.mana:
			spellCopy = spell.clone()
			print(str(spellCopy.manaCost))
			print(str(manaComp.mana))
			print(str(spellCopy.manaCost <= manaComp.mana))
			get_tree().get_current_scene().add_child(spellCopy)
			print("spending " + str(spellCopy.manaCost) + " mana out of current "+ str(manaComp.mana) + " mana")
			manaComp.spend(spellCopy.manaCost)
			
			activeSpells.append(spellCopy)
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
	


