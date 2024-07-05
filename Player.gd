extends CharacterBody2D




const JUMP_VELOCITY = -400.0

# Base Stats, may be moved into individual classes later
const SPEED = 300.0
const BASE_HEALTH = 100
const BASE_MANA_REGEN = 5
const BASE_HEALTH_REGEN = 8
var manaPool: ManaComponent 
var healthPool: HealthComponent

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	PlayerInfo.player = self
	manaPool = get_node("ManaComponent")
	manaPool.mana = PlayerInfo.mana
	manaPool.regen = BASE_MANA_REGEN
	healthPool = $HealthComponent
	healthPool.health = PlayerInfo.health
	healthPool.regen = BASE_HEALTH_REGEN

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# MOVEMENT

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		manaPool.spend(50)
		print(manaPool.mana)
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
		
func regen():
	pass
	#manaPool.restore(manaPool.regen)
	
	
func getHealth():
	return healthPool.health

func getMana():
	return manaPool.mana

# Sends signal from mana component globally, 
# needed since not every creatures mana component need to be sent globally
func _on_mana_component_mana_changed(newMana):
	Signals.emit_signal("playerManaChanged", newMana)


func _on_health_component_health_changed(newHealth):
	Signals.emit_signal("playerHealthChanged", newHealth)
	
