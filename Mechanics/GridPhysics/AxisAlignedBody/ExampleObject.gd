extends AxisAlignedBody2D

export var color = Color(255.0, 0.0, 0.0)

onready var rect = $ColorRect
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var scaled_size = collider_size * GridProperties.TILE_SIZE
	
	rect._set_size(scaled_size)
	rect.set_frame_color(color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
