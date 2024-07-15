extends Node2D

class_name SpellcastingComponent


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
		$"..".add_child(spell)
		activeSpells.append(spell)
		spell.cast()
		
func _on_spellOver(spell: Spell):
	var index = activeSpells.find(spell)
	
	if index != -1:
		activeSpells.remove_at(index)
		$"..".remove_child(spell)
	


