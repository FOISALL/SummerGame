extends StatusEffect

var dot : Array[float] = [11.5,15,20,25,30]
var duration : Array[float] = [4,6,8,10,12]
var dmgTimer : Timer
var LifeTimer : Timer

var attack : Attack


func _init():
	id = "burning"

# Called when the node enters the scene tree for the first time.
func _ready():
	dmgTimer = $DmgTimer
	LifeTimer = $LifeTimer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func refresh(effect : StatusEffect):
	super(effect)
	source = effect.source


func _on_dmg_timer_timeout():
	pass # Replace with function body.
