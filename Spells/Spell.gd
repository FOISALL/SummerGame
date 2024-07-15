extends Node2D

class_name Spell # this is meant to act as an abstract class

var spellCastingComp : SpellcastingComponent
var id: String

var source: String # will be set to casting unit
var manaCost: float
var tier: int
var lvl: int
var maxLvl: int 

# will be changed to an enum later when classes are implemented
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
	
