extends Node2D

onready var block = $Block
onready var block_2 = $Block2
onready var block_3 = $Block3
onready var block_4 = $Block4
onready var block_5 = $Block5

onready var sign_1 = $Sign1
onready var sign_2 = $Sign2
onready var sign_3 = $Sign3
onready var sign_4 = $Sign4
onready var sign_5 = $Sign5


onready var player = $Player
onready var arrow = $Arrow
onready var Scene1 = $RIT
onready var Scene2 = $TIGER
onready var current_scene = 1
onready var player_enter = 0
var screen_width: float = 0

onready var blocks1 = [block, block_2, block_3]
onready var blocks2 = [block, block_2, block_3, block_4, block_5]
onready var signs2 = [sign_1, sign_2, sign_3, sign_4, sign_5]
onready var signs1 = [sign_1, sign_2, sign_3]
onready var correct_state = false
var entered = false

onready var fade = $RIT/FadeToBlack
onready var timer = $Timer

func _ready():
	screen_width = get_viewport_rect().size.x

func _on_Interpreter_area_entered(area):
	entered = true
	var x = 14
	# Set different starting animations for each sprite
	if current_scene == 1:
		sign_1.get_node("AnimatedSprite").animation = "ASL_R"
		sign_1.position = Vector2(28,130)
		sign_2.get_node("AnimatedSprite").animation = "ASL_I"
		sign_2.position = Vector2(51, 130)
		sign_3.get_node("AnimatedSprite").animation = "ASL_T"
		sign_3.position = Vector2(73, 130)
		for s in signs1:
			s.visible = true
		for b in blocks1:
			x += 20
			b.position = Vector2(x, 105)
			b.visible = true
			b.activateCollision()
	elif current_scene != 1:
		print("new scene")
		sign_1.get_node("AnimatedSprite").animation = "ASL_T"
		sign_1.position = Vector2(27,65)
		sign_2.get_node("AnimatedSprite").animation = "ASL_I"
		sign_2.position = Vector2(52, 65)
		sign_3.get_node("AnimatedSprite").animation = "ASL_G"
		sign_3.position = Vector2(75, 65)
		sign_4.get_node("AnimatedSprite").animation = "ASL_E"
		sign_4.position = Vector2(99, 65)
		sign_5.get_node("AnimatedSprite").animation = "ASL_R"
		sign_5.position = Vector2(121, 65)
		for s in signs2:
			s.visible = true
		x = 10
		for b in blocks2:
			x += 23
			b.position = Vector2(x, 40)
			b.visible = true
			b.activateCollision()
	

func _on_Interpreter_area_exited(area):
	entered = false
	
		
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_select") and entered == true:
		print("ENTERED")
		print(block.block_state)
		print(block_2.block_state)
		print(block_3.block_state)
		if current_scene == 1 and block.block_state == 17 and block_2.block_state == 8 and block_3.block_state == 19:
			correct_state = true
			print("SUCCESS")
			arrow.visible = true
			$RIT/StaticBody2D.get_node("Collisions3_scene1").set_deferred("disabled", true)
		elif current_scene != 2 and block.block_state == 19 and block_2.block_state == 8 and block_3.block_state == 6 and block_4.block_state == 4 and block_5.block_state == 17:
			correct_state = true
			arrow.position = Vector2(20, 122)
			arrow.visible = true
			$TIGER/StaticBody2D.get_node("Collisions3_scene2").set_deferred("disabled", true)
		else:
			print("FAIL")
	if player.global_position.x < 0:
		player_enter = player.global_position.y
		reset_level();
			
func reset_level():
	fade.transition()
	yield(get_tree().create_timer(2), "timeout")
	correct_state = false
	current_scene += 1
	print(current_scene)
	if current_scene == 2:
		arrow.visible = false;
		for b in blocks2:
			b.visible = false
		for s in signs2:
			s.visible = false
		$RIT/StaticBody2D.get_node("Collisions1_scene1").set_deferred("disabled", true)
		$RIT/StaticBody2D.get_node("Collisions2_scene1").set_deferred("disabled", true)
		$TIGER/StaticBody2D.get_node("Collisions1_scene2").set_deferred("disabled", false)
		$TIGER/StaticBody2D.get_node("Collisions2_scene2").set_deferred("disabled", false)
		$TIGER/StaticBody2D.get_node("Collisions3_scene2").set_deferred("disabled", false)
		Scene1.visible = false
		Scene2.visible = true
		player.position = Vector2(screen_width - 10, player_enter)
	
	

		
		
