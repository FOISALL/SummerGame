extends Node2D
class_name Spell # this is meant to act as an abstract class
signal spellOver(spell: Spell)

var spellCastingComp : SpellcastingComponent
var id: String

var manaCost: float
var tier: int
var lvl: int
var maxLvl: int 

var source: Node2D # will be changed to an enum later when classes are implemented
var caster: Node2D
var school: String 
var type: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cast():
	pass
	
# spell constructor
static func new_Spell(id: String,source: Node2D, caster: Node2D, lvl : int) -> Spell:
	var spellName = id
	var spellPath = load("res://Spells/" +spellName + "/" + spellName +".tscn")
	var spell = spellPath.instantiate()
	spell.source = source
	spell.caster = caster
	spell.lvl = lvl
	return spell

func clone():
	var clone : Spell = self.duplicate()
	clone.id = self.id
	clone.source = self.source
	clone.caster = self.caster
	clone.lvl = self.lvl
	return clone
	
	
	
	
	
