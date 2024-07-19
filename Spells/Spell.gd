extends Node2D

class_name Spell # this is meant to act as an abstract class

var spellCastingComp : SpellcastingComponent
var id: String

var manaCost: float
var tier: int
var lvl: int
var maxLvl: int 

var source: Node2D # will be changed to an enum later when classes are implemented
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
static func new_Spell(id: String,source: Node2D, lvl : int):
	var spellName = id
	var spellPath = load("res://Spells/" +spellName + "/" + spellName +".tscn")
	var spell = spellPath.instantiate()
	spell.source = source
	spell.lvl = lvl
	return spell
	
