extends AxisAlignedBody2D

var animation_speed = 3
var is_moving = false

# For animating the player
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true
	property_list_changed_notify()

func _process(delta):
	try_start_moving()
	
func set_animation_running(input_vector: Vector2):
	animationTree.set("parameters/Idle/blend_position", input_vector)
	animationTree.set("parameters/Run/blend_position", input_vector)
	animationState.travel("Run")
	
func set_animation_idle():
	animationState.travel("Idle")

func get_input_vector() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if input_vector.x == 0:
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	return input_vector.snapped(Vector2.ONE)
		
func try_start_moving():
	if is_moving:
		return
	
	var input_vector = get_input_vector()
	var motion_vector = input_vector * Properties.TILE_SIZE
	
	if input_vector != Vector2.ZERO:
		set_animation_running(input_vector)
		
		# If the vector points to nothing, move 
		if can_move(motion_vector):
			start_moving(motion_vector)
		
		# Otherwise, try to push whatever object it points to
		else:
			try_push(motion_vector)
	else:
		set_animation_idle()	

# Attempts to push all objects lined up in the direction of a motion vector
func try_push(motion_vector: Vector2):
	if not rays.has_any_collisions():
		return
	
	var objects = rays.get_all_colliding_objects()
	var to_push = []
	
	while objects.size() != 0:
		var obj = objects[0]
		objects.remove(0)
		
		var aab = obj as AxisAlignedBody2D
		if aab == null:
			return

		to_push.append(aab)
		aab.rays.cast_all_by_motion(motion_vector)
		objects.append_array(aab.rays.get_all_colliding_objects())
	
	for t in to_push:
		move(t, motion_vector)
	
	start_moving(motion_vector)

# Move any kinematic body according to a motion vector
func move(object: KinematicBody2D, motion_vector: Vector2) -> Tween:
	var tween = create_tween()
	tween.tween_property(object, "position", object.position + motion_vector, 1.0 / animation_speed)
	tween.set_trans(Tween.TRANS_SINE)
	return tween

# Determines whether the player can move according to a motion vector
func can_move(motion_vector: Vector2) -> bool:
	rays.cast_all_by_motion(motion_vector)
	return not rays.has_any_collisions()

# Start animating the player movement
func start_moving(motion_vector: Vector2):
	is_moving = true
	var tween = move(self, motion_vector)
	tween.tween_callback(self, "on_move_ended")

# Allow moving after animation terminates
func on_move_ended():
	is_moving = false
