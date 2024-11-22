extends Node2D

onready var block = $Block
onready var block_2 = $Block2
onready var block_3 = $Block3

onready var sign_1 = $Sign1
onready var sign_2 = $Sign2
onready var sign_3 = $Sign3

onready var player = $Player


onready var blocks = [block, block_2, block_3]
onready var signs = [sign_1, sign_2, sign_3]
onready var correct_state = false
var entered = false

onready var fade = $FadeToBlack

func _on_Interpreter_area_entered(area):
	entered = true
	for b in blocks:
		b.visible = true
		b.activateCollision()
	# Set different starting animations for each sprite
	sign_1.get_node("AnimatedSprite").animation = "ASL_R"
	sign_2.get_node("AnimatedSprite").animation = "ASL_I"
	sign_3.get_node("AnimatedSprite").animation = "ASL_T"
	for s in signs:
		s.visible = true
		s.activateCollision()

func _on_Interpreter_area_exited(area):
	entered = false
	
		
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_select") and entered == true:
		print("ENTERED")
		if block.block_state == 0 and block_2.block_state == 1 and block_3.block_state == 2:
			correct_state = true
			print("SUCCESS")
			reset_level()
		else:
			print("FAIL")
			
func reset_level():
	fade.transition()
	#await fade.get_node("AnimationPlayer").animation_finished
	player.position = Vector2(270, 75)
	for b in blocks:
		b.visible = false
	for s in signs:
		s.visible = false
	
	

		
		

