extends StatusEffect

var dot : Array[float] = [11.5,15,20,25,30]
var duration : Array[float] = [4,6,8,10,12]
var dmgTimer : Timer
var lifeTimer : Timer

var attack : Attack

var targetHealth : HealthComponent


func _init():
	id = "burning"

# Called when the node enters the scene tree for the first time.
func _ready():
	lifeTimer = $lifeTimer
	lifeTimer.wait_time = duration[lvl]
	lifeTimer.one_shot = true
	
	dmgTimer = $DmgTimer
	dmgTimer.wait_time = 1.5
	
	attack = Attack.new()
	attack.attackDamage = dot[lvl] * dmgTimer.wait_time

func activate():
	dmgTimer.start()
	lifeTimer.start()
	
# refreshing behaviour may be changed later if needed
# current behaviour ====
# set owner of fire to owner of last applied debuff
# restart duration
# if new fire is stronger that previous, lvl up tp stronger fire.
# a low lvl fire can infinitely refresh a higher lvl fire
func refresh(effect : StatusEffect):
	super(effect)
	lifeTimer.start()
	if effect.lvl > lvl:
		lvl = effect.lvl
	
func setHealthComp(healthComp: HealthComponent):
	targetHealth = healthComp

func _on_dmg_timer_timeout():
	targetHealth.damage(attack)
	print("burn damage")

# I believe there is a chance that this signal is caught by everyone who has a satuseffect componenet whh is not intended.
func _on_life_timer_timeout():
	emit_signal("effectOver",self)
	print("emitting effect over signal")
