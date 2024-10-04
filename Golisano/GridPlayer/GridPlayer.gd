extends KinematicBody2D

const TILE_SIZE = 16

var animation_speed = 3
var is_moving = false

# For animating the player
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true
	position = position.snapped(Vector2.ONE * TILE_SIZE)

func get_input_vector() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	return input_vector

func _process(delta):
	try_start_moving()
		
func try_start_moving():
	if is_moving:
		return
	
	var input_vector = get_input_vector()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		
		start_moving(input_vector)
	else:
		animationState.travel("Idle")	

func start_moving(input_vector: Vector2):
	is_moving = true
	var tween = create_tween()
	tween.tween_property(self, "position", position + (input_vector * TILE_SIZE), 1.0 / animation_speed)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_callback(self, "on_move_ended")

func on_move_ended():
	is_moving = false
