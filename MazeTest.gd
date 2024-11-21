extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gotKey = false
var light_used = false
var light_on = false
var time_start = 0
var time_now = 0
var time_light_start = 0
var time_flash_start = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_now = OS.get_unix_time()  #is constantly increasing
	var time_elapsed = time_now - time_start
	var time_light_elapsed = time_now - time_light_start
	var time_flash_elapsed = time_now - time_flash_start
	
	#this resets light visibility after 5 sec(for temporary power up after key obtained)
	if(time_light_elapsed == 6):
		light_on = false
		$Player/Light2D.scale.x = 0.5
		$Player/Light2D.scale.y = 0.5
#	if(time_elapsed % 4 == 0):
#		_flashLight()
#	if(time_flash_elapsed == 2):
#		$Player/Light2D.scale.x = 0.5
#		$Player/Light2D.scale.y = 0.5
#		time_flash_start = 0
#		time_flash_elapsed = 0
		


func _tempLight():
	time_light_start = OS.get_unix_time()
	$Player/Light2D.scale.x = 2
	$Player/Light2D.scale.y = 2


#func _flashLight():
#	if(light_on == true):
#		return
#	time_flash_start = OS.get_unix_time()
#	$Player/Light2D.scale.x = 0.25
#	$Player/Light2D.scale.y = 0.25

	

func _on_Key_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if(body.get_name() == "Player"):
		if (light_used == false):
			_tempLight()
			light_used = true
			light_on = true
		gotKey = true
		print("Got a key!")
		$Key.visible = false
		

		


func _on_Door_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if(body.get_name() == "Player" and !gotKey):
		print("Door is locked...")
	elif (body.get_name() == "Player" and gotKey):
		print("Door opened.")
		
