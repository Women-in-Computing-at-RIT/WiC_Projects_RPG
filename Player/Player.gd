extends KinematicBody2D

const ACCELERATION = 600
const MAX_SPEED = 100
const FRICTION = 800

# For Blocks
const PUSH_SPEED = 20
const BLOCK_MAX_VELOCITY = 50

var velocity = Vector2.ZERO

# Called every tic 
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta) # accounts for frame rate
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) # accounts for frame rate
	
	if get_slide_count() > 0: # Handle block collisions
		check_box_collision(velocity)
		
	velocity = move_and_slide(velocity) # auto handles delta 

func check_box_collision(velocity: Vector2) -> void:
	# print(velocity.x, velocity.y)
	if abs(velocity.x) + abs(velocity.y) > BLOCK_MAX_VELOCITY:
		return
	var box = get_slide_collision(0).collider as Box
	if box:
		box.push(PUSH_SPEED * velocity)
