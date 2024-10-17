extends AxisAlignedBody2D

export var labelText = ""
export var labelColor = Color(0.0, 1.0, 0.0)

onready var background = $ColorRect
onready var label = $Label

func _ready():
	var scaled_size = collider_size * Properties.TILE_SIZE
	background._set_size(scaled_size)
	label._set_size(scaled_size / label.get_scale())
	label.add_color_override("font_color", labelColor)
	
