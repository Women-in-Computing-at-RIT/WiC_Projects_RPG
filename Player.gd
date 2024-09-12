extends KinematicBody2D

const MAX_SPEED = 100

var velocity = Vector2.ZERO

# Called every tic 
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector
	else:
		velocity = Vector2.ZERO

	move_and_collide(velocity * delta * MAX_SPEED) # accounts for frame rate
