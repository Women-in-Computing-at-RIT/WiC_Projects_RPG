extends AxisAlignedBody2D

# Exposes a 'fillColor' property in the inspector
export var fillColor = Color(1.0, 0.0, 0.5)

onready var rect = $ColorRect

func _ready():
	var scaled_size = collider_size * GridProperties.TILE_SIZE
	rect._set_size(scaled_size)
	rect.set_frame_color(fillColor)
