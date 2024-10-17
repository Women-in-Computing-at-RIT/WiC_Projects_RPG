extends AxisAlignedBody2D

export var labelText = ""
export var labelColor = Color(0.0, 1.0, 0.0)
export var backgroundColor = Color(0.0, 0.0, 0.0)

onready var background = $ColorRect
onready var label = $Label

func _ready():
	var scaled_size = collider_size * Properties.TILE_SIZE
	
	background._set_size(scaled_size)
	background.set_frame_color(backgroundColor)
	
	label.set_text(labelText)
	label._set_size(scaled_size / label.get_scale())
	label.add_color_override("font_color", labelColor)
	
