extends Spell

# class_name FlameBlast

var DoT : Array[float] = [2,5,11.5,18,25]
var AoE : Array[float] = [75,100,125,175,250]
var dmg : Array[float] = [2,5,11.5,18,25]

@export var anim: AnimationPlayer
func _init():
	pass

# Called when the node enters the scene tree for the first time.
func _ready(): # I will have to evaluate how to initialise it correctly from init if needed
	#anim = $AnimatedSprite2D/AnimationPlayer
	id = "flameBlast"
	maxLvl = 4
	manaCost = 40


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !anim.is_playing():
		Signals.emit_signal("spellOver",self)
		#get_parent().remove_child(self)
		#self.queue_free()

	
func cast():
	anim.play("blast")
	print("blast!!")
	print(str(global_position))
	


func _on_area_entered(area):
	print("ATTACK!!")
	if area is HurtboxComponent:
		var hurtbox : HurtboxComponent = area
		
		var attack  = Attack.new()
		attack.attackDamage = dmg[lvl]
		attack.attackPos = global_position
		
		hurtbox.damage(attack)
		
# constructor
#static func new_FlameBlast(source: Node2D, lvl : int):
#	var spellName = "flameBlast"
#	var spellPath = load("res://Spells/" +spellName + "/" + spellName +".tscn")
#	var flameBlast = spellPath.instantiate()
#	flameBlast.source = source
#	flameBlast.lvl = lvl
#	return flameBlast
	
