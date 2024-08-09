extends CharacterBody2D

const JUMP_VELOCITY = -400.0

# Base Stats, may be moved into individual classes later
const SPEED = 300.0
const BASE_HEALTH = 200
const BASE_MANA_REGEN = 5
const BASE_HEALTH_REGEN = 8
const BASE_DAMAGE = 15

var isAttacking = false

# Components
var manaPool: ManaComponent
var healthPool: HealthComponent
var spells: SpellcastingComponent
var movement: MovementComponent

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D/AnimationPlayer
@onready var anim2 = $AnimatedSprite2D2/AnimationPlayer
func _ready():
	
	# I wanted to set this variable in the UI but that causes a bug for some reason so I do it manualy isntead
	$AnimatedSprite2D/meleeAttack/CollisionShape2D.disabled = true
	
	
	# assign reference to global scripts
	PlayerInfo.player = self
	InteractionManager.player = self
	
	# assign components and base values
	movement = $MovementComponent
	movement.gravity = true
	movement.s = self
	
	manaPool = get_node("ManaComponent")
	manaPool.mana = PlayerInfo.mana
	manaPool.regen = BASE_MANA_REGEN
	
	healthPool = $HealthComponent
	healthPool.MAX_HEALTH = BASE_HEALTH
	healthPool.health = PlayerInfo.health
	healthPool.regen = BASE_HEALTH_REGEN
	
	spells = $SpellcastingComponent
	# load spells TEMPORARY DEBUGGING CODE! ###################
	var spellName = "flameBlast"
	var flameBlast = Spell.new_Spell(spellName,self,self, 1)
	#flameBlast.position = global_position
	spellName = "fireBall"
	var spellPath = load("res://Spells/" +spellName + "/" + spellName +".tscn")
	var fireBall = Spell.new_Spell(spellName,self,self, 1)
	
	print("blast pos" + str(flameBlast.position))
	
	spells.learnedSpells.append(fireBall)
	spells.preparedSpells.append(fireBall)
	
	spells.learnedSpells.append(flameBlast)
	spells.preparedSpells.append(flameBlast)
	



func _physics_process(delta):
	
	if(!isAttacking):
		anim.play("Idle")

	# MOVEMENT

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		movement.jump(JUMP_VELOCITY)
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	movement.walk(direction, SPEED)
		
	
		
func regen():
	pass
	#manaPool.restore(manaPool.regen)
	
	
func getHealth():
	return healthPool.health

func getMana():
	return manaPool.mana
	
# this will prob be moved elsewhere later
func _input(event):
	if event.is_action_pressed("attack"):
		anim.play("meleeAttack")	
		isAttacking = true
		anim.speed_scale = 3
		
	if event.is_action_pressed("castspell"):
		print("gonna cast spell")
		spells.castSpell()
		#anim2.play("blast")

# Sends signal from mana component globally, 
# needed since not every creatures mana component need to be sent globally
# This signal is the picked up by the UI
func _on_mana_component_mana_changed(newMana):
	Signals.emit_signal("playerManaChanged", newMana)

# Sends signal from health component globally
func _on_health_component_health_changed(prevHealth, newHealth):
	Signals.emit_signal("playerHealthChanged", newHealth)
	

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "meleeAttack":
		isAttacking = false
		anim.speed_scale = 1


func _on_melee_attack_area_entered(area):
	if area is HurtboxComponent:
		var hurtbox : HurtboxComponent = area
		
		var attack  = Attack.new()
		attack.attackDamage = BASE_DAMAGE
		attack.attackPos = global_position
		
		hurtbox.damage(attack)
