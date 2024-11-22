extends StaticBody2D

onready var collision_shape_2d = $choice_area/collision
onready var animated_sprite = $AnimatedSprite
onready var block_entered = false
var block_state = 1

func activateCollision():
	get_node("hitbox").set_deferred("disabled", false)

func _on_choice_area_area_entered(area):
	print("TRUE TURE TUREU")
	block_entered = true

func _on_choice_area_area_exited(area):
	print("ITS FALSE NOW")
	block_entered = false

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_select") and block_entered == true:
		block_state += 1
		block_state %= 26
		if block_state >= 0 and block_state <= 25:
			animated_sprite.play("choice_" + char(65 + block_state))


