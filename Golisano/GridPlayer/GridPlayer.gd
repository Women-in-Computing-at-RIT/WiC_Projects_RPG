extends KinematicBody2D

const TILE_SIZE = 16

var animation_speed = 3
var is_moving = false

# For animating the player
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

onready var ray = $RayCast2D

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
	var motion_vector = input_vector * TILE_SIZE
	
	if input_vector != Vector2.ZERO:
		# Check for collisions
		
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		if can_move(motion_vector):
			start_moving(motion_vector)
	else:
		animationState.travel("Idle")	

func can_move(motion_vector: Vector2) -> bool:
	ray.set_cast_to(motion_vector)
	ray.force_raycast_update()
	return not ray.is_colliding()

func start_moving(motion_vector: Vector2):
	is_moving = true
	var tween = create_tween()
	tween.tween_property(self, "position", position + motion_vector, 1.0 / animation_speed)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_callback(self, "on_move_ended")

func on_move_ended():
	is_moving = false
