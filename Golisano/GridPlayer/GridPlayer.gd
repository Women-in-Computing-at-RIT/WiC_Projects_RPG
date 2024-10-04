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
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	return input_vector.snapped(Vector2.ONE)
		
func try_start_moving():
	if is_moving:
		return
	
	var input_vector = get_input_vector()
	var motion_vector = input_vector * TILE_SIZE
	
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
	return obj.get_class() == "KinematicBody2D"

# Attempts to push all objects lined up in the direction of a motion vector
func try_push(motion_vector: Vector2):
	if not ray.is_colliding():
		return
		
	var first = ray.get_collider()
		
	if not is_object_pushable(first):
		return
		
	# Approach:
	#  - Create a 'mobile' raycast that moves from object to object in a straight line (motion vec)
	#  - If an unpushable object is encountered, pushing fails
	#  - If the cast does not collide with anything after being moved, pushing succeeds
	var qray = RayCast2D.new()
	
	# Re-use ray transform so the new raycast is positioned at the center of the object
	qray.set_transform(ray.get_transform())
	
	qray.set_enabled(true)
	qray.set_cast_to(motion_vector)
	
	first.add_child(qray)
	qray.force_raycast_update()
	
	# Objects to push
	var objects = [first]
	
	while (qray.is_colliding()):
		var obj = qray.get_collider()
		qray.get_parent().remove_child(qray)
		
		if is_object_pushable(obj):
			objects.append(obj)
		else:
			# A non-pushable object is encountered - pushing cannot proceed
			return
			
		# Add the raycast to the current object
		obj.add_child(qray)
		qray.force_raycast_update()
	
	# Terminate the ray
	qray.queue_free()
	
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
	ray.set_cast_to(motion_vector)
	ray.force_raycast_update()
	return not ray.is_colliding()

# Start animating the player movement
func start_moving(motion_vector: Vector2):
	is_moving = true
	var tween = move(self, motion_vector)
	tween.tween_callback(self, "on_move_ended")

# Allow moving after animation terminates
func on_move_ended():
	is_moving = false
