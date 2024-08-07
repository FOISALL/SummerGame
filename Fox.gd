extends CharacterBody2D

# base stats, may be moved later, I dont know
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const BASE_HEALTH = 500
const BASE_REGEN = 0.3

# attached components
var healthPool: HealthComponent

@onready var healthBar = $HealthBar


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	
	# instantiate component
	healthPool = $HealthComponent
	healthPool.MAX_HEALTH = BASE_HEALTH
	healthPool.health = BASE_HEALTH
	healthPool.regen = BASE_REGEN
	
	healthBar.max_value = BASE_HEALTH
	healthBar.value = BASE_HEALTH
	healthBar.hide()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if false:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if false:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_health_component_health_changed(prevHealth, health):
	print(health)
	if (prevHealth > health):
		
		healthBar.value = healthPool.health
		healthBar.show()
		$HealthBar/HealthbarVisibleTimer.start()

func _on_healthbar_visible_timer_timeout():
	healthBar.hide()
