extends Area2D
class_name HitboxComponent

@export var healthComp : HealthComponent

func damage(attack: Attack):
	if healthComp:
		healthComp.damage(attack)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
