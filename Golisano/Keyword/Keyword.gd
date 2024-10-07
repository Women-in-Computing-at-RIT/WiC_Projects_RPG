extends KinematicBody2D

func _ready():
	position = position.snapped(Vector2.ONE * Properties.TILE_SIZE)
	print("Adjusted position: %s" % position)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
# func _ready():
# 	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
