extends Spell

# class_name FlameBlast

var DoT : Array[float] = [2,5,11.5,18,25]
var AoE : Array[float] = [75,100,125,175,250]
var dmg : Array[float] = [2,5,11.5,18,25]

@export var anim: AnimationPlayer

var burn : StatusEffect

# Called when class is created
func _init():
	id = "flameBlast"
	maxLvl = 4
	manaCost = 40

# Called when the node enters the scene tree for the first time.
func _ready(): # I will have to evaluate how to initialise it correctly from init if needed
	anim = $AnimatedSprite2D/AnimationPlayer
	burn = StatusEffect.new_effect("burning",self,self, 1)

	
func cast():
	anim.play("blast")
	print("blast!!")
	position = caster.position
	print(str(global_position))
	


func _on_area_entered(area):
	print("ATTACK!!")
	if area is HurtboxComponent:
		var hurtbox : HurtboxComponent = area
		
		# attack to sent to targets
		var attack  = Attack.new()
		attack.attackDamage = dmg[lvl]
		attack.attackPos = global_position
		attack.effect = burn
		
		hurtbox.damage(attack)
		
	

# animation plays once, then spell ends
func _on_animation_player_animation_finished(_anim_name):
	print("blast done!")
	# this is needed since the spellcasting component handling it will be destroyed.
	# It is worth considering having the source spellcaster handler all the childspells
	if(caster == null):
		queue_free()
	else:
		emit_signal("spellOver",self)
