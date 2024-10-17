extends KinematicBody2D

const ACCELERATION = 601
const MAX_SPEED = 100
const FRICTION = 800

# For Character Actions
enum{
	MOVE,
	AXE
}
var state = MOVE

# For Blocks
const PUSH_SPEED = 20
const BLOCK_MAX_VELOCITY = 50

# For animating the player
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

var velocity = Vector2.ZERO

# Called every tic 
func _process(delta):
	# Action controller
	match state:
		MOVE:
			$"Action Sprite".hide()
			$Sprite.show()
			move_state(delta)
		AXE:
			$Sprite.hide()
			$"Action Sprite".show()
			axe_state(delta)
	
	
func check_box_collision(velocity: Vector2) -> void:
	# print(velocity.x, velocity.y)
	if abs(velocity.x) + abs(velocity.y) > BLOCK_MAX_VELOCITY:
		return
	var box = get_slide_collision(0).collider as Moveable
	if box:
		box.push(PUSH_SPEED * velocity)
		
		
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		print(input_vector)
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Axe/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta) # accounts for frame rate
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) # accounts for frame rate
	
	if get_slide_count() > 0: # Handle block collisions
		check_box_collision(velocity)
		
	velocity = move_and_slide(velocity) # auto handles delta 
	
	# Handle Actions
	if Input.is_action_just_pressed("ui_axe"):
		state = AXE
	
	
func axe_state(delta):
	animationState.travel("Axe")
	velocity = Vector2.ZERO
	
func axe_finished():
	state = MOVE
