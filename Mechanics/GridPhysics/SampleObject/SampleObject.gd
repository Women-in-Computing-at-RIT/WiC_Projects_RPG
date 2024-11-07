tool
extends AxisAlignedBody2D

# Exposes a 'fillColor' property in the inspector
export var fillColor = Color(1.0, 0.0, 0.5) setget _on_color_changed

onready var rect = $ColorRect

func _ready():
	var scaled_size = collider_size * GridProperties.TILE_SIZE
	rect._set_size(scaled_size)
	rect.set_frame_color(fillColor)
	
func _on_color_changed(color):
	fillColor = color
	if rect:
		rect.set_frame_color(fillColor)
		rect.update()
	property_list_changed_notify()

# Override _on_size_changed to resize the background when the 
# collider size is changed from the editor inspector
func _on_size_changed(size):
	._on_size_changed(size)
	if rect:
		rect._set_size(size * GridProperties.TILE_SIZE)
	
