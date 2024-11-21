extends KinematicBody2D

func _ready():
	$AnimatedSprite.play("Idle_Right")
	$AnimatedSprite.playing = true 

const ACCELERATION = 600
const MAX_SPEED = 100
const FRICTION = 800

# For Character Actions
enum{
	MOVE
}
var state = MOVE

var velocity = Vector2.ZERO

# Called every tic 
#func _process(delta):
	# Action controller
#	match state:
#		MOVE:
#			move_state(delta)

#var direction = "left"

#func move_state(delta):
#	var input_vector = Vector2.ZERO
#	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
#	input_vector = input_vector.normalized()
	
	
#	if input_vector != Vector2.ZERO:
#		print(input_vector)
#		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta) # accounts for frame rate
#		if input_vector.x < 0:
#			direction = "left"
#			$AnimatedSprite.play("Walk_Left")
#		else:
#			direction = "right"
#			$AnimatedSprite.play("Walk_Right")
#			
#	else:
#		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) # accounts for frame rate
#		if direction == "left":
#			$AnimatedSprite.play("Idle_Left")
#		else:
#			$AnimatedSprite.play("Idle_Right")
#
#	velocity = move_and_slide(velocity) # auto handles delta 