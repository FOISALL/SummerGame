extends Spell


var AoE : Array[float] = [75,100,125,175,250]
var dmg : Array[float] = [11.5,25,32,40,50]

const SPEED: float = 500

var velocity : Vector2

var charging : bool = true

var manaPool: ManaComponent
var spells: SpellcastingComponent
var movement: MovementComponent



@export var anim: AnimationPlayer

# called when class in created
func _init():
	id = "fireball"
	maxLvl = 4
	manaCost = 40

# Called when the node enters the scene tree for the first time.
func _ready():
	lvl = 1 # should be instantiated from the spell user
	manaPool = $ManaComponent
	manaPool.mana = 2*manaCost
	manaPool.regen = 0
	
	#movement = $MovementComponent
	#movement.s = self
	
	anim = $AnimatedSprite2D/AnimationPlayer
	
	spells = $SpellcastingComponent
	
	# here I wanted to add manacomp to spellcom through UI but it for some reason thinks 
	# that the manacomp has 0 mana then for some reasom
	# Answer: Since the mana is added in the ready func of manapool. It has not yet been intialised
	# Solution: add through code like below, or make mana values non exports and set them in _init()
	spells.manaComp = manaPool
	 
	var flameBlast: Spell = Spell.new_Spell("flameBlast",source,self, max(0,lvl-1))
	
	spells.learnedSpells.append(flameBlast)
	spells.preparedSpells.append(flameBlast)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setVelocity(vel : Vector2):
	pass
	
func _physics_process(delta):
	if !charging:
		position += velocity * delta
	else:
		position = source.position
		rotation = source.rotation
	


func cast():
	anim.play("Charge")
	anim.queue("Flying")
	print("blast!!")
	print(str(global_position))


# Deal damage on contact
func _on_area_entered(area):
	print(area.get_collision_layer())
	print("ATTACK!!")
	if area is HurtboxComponent:
		
		print("damagetime")
		var hurtbox : HurtboxComponent = area
		
		# create attack
		var attack  = Attack.new()
		attack.attackDamage = dmg[lvl]
		attack.attackPos = global_position
		
		hurtbox.damage(attack)
		manaPool.spend(5)


func _on_collisionbox_body_entered(body):
	spells.castSpell()
	emit_signal("spellOver",self)


func _on_mana_component_mana_changed(newMana):
	if newMana <= 50:
		print(newMana)
		
		spells.castSpell()
		print("fireball end")
		emit_signal("spellOver",self)


# change from charging state to launched state, might change in the future
func _on_animation_player_animation_changed(old_name, new_name):
	charging = false
	velocity = source.velocity.normalized() * 420 
	manaPool.regen = -10








