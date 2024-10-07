extends AxisAlignedBody2D

var animation_speed = 3
var is_moving = false

# For animating the player
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

#onready var ray = $RayCast2D

func _ready():
	animationTree.active = true
	property_list_changed_notify()
#	position = position.snapped(Vector2.ONE * Properties.TILE_SIZE)

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

# Determines whether an object can be pushed
func is_object_pushable(obj: Object) -> bool:
	return obj is AxisAlignedBody2D

# Attempts to push all objects lined up in the direction of a motion vector
func try_push(motion_vector: Vector2):
	if not ray.is_colliding():
		return
		
	if not is_object_pushable(ray.get_collider()):
		return
		
	var obj = ray.get_collider() as AxisAlignedBody2D
	obj.cast_ray(motion_vector)
	
	# Objects to push
	var objects = [obj]
	
	while (obj.is_ray_colliding()):
	
		var collider = obj.ray.get_collider()
		if not is_object_pushable(collider):
			return
		obj = collider as AxisAlignedBody2D
		obj.cast_ray(motion_vector)
		objects.append(obj)
	
	for i in range(objects.size() - 1, -1, -1):
		move(objects[i], motion_vector)
		
	start_moving(motion_vector)

# Move any kinematic body according to a motion vector
func move(object: KinematicBody2D, motion_vector: Vector2) -> Tween:
	var tween = create_tween()
	tween.tween_property(object, "position", object.position + motion_vector, 1.0 / animation_speed)
	tween.set_trans(Tween.TRANS_SINE)
	return tween

# Determines whether the player can move according to a motion vector
func can_move(motion_vector: Vector2) -> bool:
	cast_ray(motion_vector)
#	ray.set_cast_to(motion_vector)
#	ray.force_raycast_update()
	return not ray.is_colliding()

# Start animating the player movement
func start_moving(motion_vector: Vector2):
	is_moving = true
	var tween = move(self, motion_vector)
	tween.tween_callback(self, "on_move_ended")

# Allow moving after animation terminates
func on_move_ended():
	is_moving = false
