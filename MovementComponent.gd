extends Node2D
class_name MovementComponent

@export var gravity : bool

var s : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if gravity:
		# Add the gravity.
		if not s.is_on_floor():
			s.velocity.y += s.gravity * delta
	s.move_and_slide()

func jump(speed):
	s.velocity.y = speed

func walk(direction, speed):
		# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	# Link to reddit post that told me how to flip properly. This was not what I ecpected
	# https://www.reddit.com/r/godot/comments/1ddalbo/how_to_properly_flip_characters/
	if direction == -1:
		s.scale = Vector2(1, -1)
		s.rotation = PI
	elif direction == 1:
		s.scale = Vector2(1, 1)
		s.rotation = 0
	
	if direction:
		s.velocity.x = direction * speed
	else:
		s.velocity.x = move_toward(s.velocity.x, 0, speed)

