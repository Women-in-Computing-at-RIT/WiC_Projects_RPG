extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var letter = 0
var frames = 12 #set to 26 when we actually get letters

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_left"):
		if letter == frames - 1:
			letter = 0
		else:
			letter += 1
		set_frame(letter)
	if Input.is_action_just_pressed("ui_right"):
		if letter == 0:
			letter = frames - 1
		else:
			letter -= 1
		set_frame(letter)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
