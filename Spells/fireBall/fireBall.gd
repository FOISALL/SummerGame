extends Spell


var AoE : Array[float] = [75,100,125,175,250]
var dmg : Array[float] = [2,5,11.5,18,25]

const SPEED: float = 500

var velocity : Vector2

var charging : bool = true

@export var anim: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	id = "flameBlast"
	maxLvl = 4
	manaCost = 40
	lvl = 1 # should be instantiated from the spell user
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setVelocity(vel : Vector2):
	pass
	
func _physics_process(delta):
	if !charging:
		position += velocity * delta
	


func cast():
	anim.play("Charge")
	anim.queue("Flying")
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


func _on_animation_player_animation_changed(old_name, new_name):
	charging = false
