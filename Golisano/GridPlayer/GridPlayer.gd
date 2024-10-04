extends Player

const TILE_SIZE = 16

var animation_speed = 3
var is_moving = false

func _ready():
	._ready()
	position = position.snapped(Vector2.ONE * TILE_SIZE)

func _process(delta):
	move_state(delta)

func move_state(delta):
	
	if is_moving:
		return
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Axe/blend_position", input_vector)
		animationState.travel("Run")
		
		is_moving = true
		var tween = create_tween()
		tween.tween_property(self, "position", position + (input_vector * TILE_SIZE), 1.0 / animation_speed)
		tween.set_trans(Tween.TRANS_SINE)
		tween.tween_callback(self, "on_move_ended")
	else:
		animationState.travel("Idle")


func on_move_ended():
	is_moving = false
