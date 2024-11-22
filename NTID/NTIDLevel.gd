extends Node2D

# Set up Letter blocks
onready var block = $Block
onready var block_2 = $Block2
onready var block_3 = $Block3
onready var block_4 = $Block4
onready var block_5 = $Block5

# Set up signs
onready var sign_1 = $Sign1
onready var sign_2 = $Sign2
onready var sign_3 = $Sign3
onready var sign_4 = $Sign4
onready var sign_5 = $Sign5

# Player
onready var player = $Player
onready var arrow = $Arrow

# Different scenes for words
onready var Scene1 = $RIT
onready var Scene2 = $TIGER
onready var current_scene = 1

# Where to start the player when they enter a new scene
onready var player_enter = 0
var screen_width: float = 0

# Blocks and signs for different levels
onready var blocks1 = [block, block_2, block_3]
onready var blocks2 = [block, block_2, block_3, block_4, block_5]
onready var signs2 = [sign_1, sign_2, sign_3, sign_4, sign_5]
onready var signs1 = [sign_1, sign_2, sign_3]

# Checks if current state is a solution
onready var correct_state = false
var entered = false

# Fade to different levels timer
onready var fade = $RIT/FadeToBlack
onready var timer = $Timer


func _ready():
	# Get screen width for entrance from right
	screen_width = get_viewport_rect().size.x

# author: Sydney Tsin (sst8237), Natalie Zesch
func _on_Interpreter_area_entered(area):
	entered = true
	var x = 14 # x value for blocks to iterate through
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
	# TODO: Error with changing current scene just by one for some reason increases by a lot
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
	
		
# author: Sydney Tsin (sst8237), Natalie Zesch
func _physics_process(delta):
	# If space is pushed while on interpreter, check solution
	if Input.is_action_just_pressed("ui_select") and entered == true:
		print("ENTERED")
		# solution = "RIT"
		if current_scene == 1 and block.block_state == 17 and block_2.block_state == 8 and block_3.block_state == 19:
			correct_state = true
			print("SUCCESS")
			arrow.visible = true # display arrow
			$RIT/StaticBody2D.get_node("Collisions3_scene1").set_deferred("disabled", true) # disable collision by exit
		# solution = "TIGER"
		elif current_scene != 2 and block.block_state == 19 and block_2.block_state == 8 and block_3.block_state == 6 and block_4.block_state == 4 and block_5.block_state == 17:
			correct_state = true
			arrow.position = Vector2(20, 122)
			arrow.visible = true
			$TIGER/StaticBody2D.get_node("Collisions3_scene2").set_deferred("disabled", true)
		else:
			print("FAIL")
	
		# if player exits screen left reset level
		if player.global_position.x < 0:
			player_enter = player.global_position.y
			reset_level();
			
# Reset current level and set up next level
# author: Sydney Tsin (sst8237)
func reset_level():
	fade.transition() # TODO: fade to black transition is buggy plays fade twice
	yield(get_tree().create_timer(2), "timeout") # wait to switch scenes until after fade is done
	correct_state = false
	current_scene += 1
	print(current_scene)
	# reset scene
	if current_scene == 2:
		arrow.visible = false;
		for b in blocks2:
			b.visible = false
		for s in signs2:
			s.visible = false
		# Set up collisions for next scene and remove old ones
		$RIT/StaticBody2D.get_node("Collisions1_scene1").set_deferred("disabled", true)
		$RIT/StaticBody2D.get_node("Collisions2_scene1").set_deferred("disabled", true)
		$TIGER/StaticBody2D.get_node("Collisions1_scene2").set_deferred("disabled", false)
		$TIGER/StaticBody2D.get_node("Collisions2_scene2").set_deferred("disabled", false)
		$TIGER/StaticBody2D.get_node("Collisions3_scene2").set_deferred("disabled", false)
		# Switch scenes
		Scene1.visible = false
		Scene2.visible = true
		player.position = Vector2(screen_width - 10, player_enter)
	
	

		
		

