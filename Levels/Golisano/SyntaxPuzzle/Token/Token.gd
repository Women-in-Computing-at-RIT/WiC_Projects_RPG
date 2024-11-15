tool
class_name Token
extends AxisAlignedBody2D

const Grid = preload("res://Mechanics/GridPhysics/GridProperties.gd")

export var textColor = Color(1.0, 1.0, 1.0) setget _on_text_color_changed

# Temporary bg color until a sprite is made
export var backgroundColor = Color(0, 0, 0) setget _on_bg_color_changed

# Token text
export var text = "a" setget _on_text_changed

onready var label = $Label
onready var background = $Background

# Position of the token object when the scene started
var initial_position

func _on_text_color_changed(newColor):
	textColor = newColor
	if label:
		label.remove_color_override("font_color")
		label.add_color_override("font_color", textColor)
	update()
	property_list_changed_notify()

func _on_bg_color_changed(newColor):
	backgroundColor = newColor
	if background:
		background.set_frame_color(newColor)
	update()
	property_list_changed_notify()
	
func _on_text_changed(newText):
	text = newText
	if label:
		label.set_text(newText)
	update()
	property_list_changed_notify()

func _ready():
	# Initialize element values from exported variables
	background.set_frame_color(backgroundColor)
	label.set_text(text)
	label.add_color_override("font_color", textColor)
	
	# Store the initial position so we can put it back where it came
	# from if needed
	initial_position = position
	
	resize_elements(collider_size)
	
func _on_size_changed(size):
	._on_size_changed(size)
	
	# Update label & bg size
	resize_elements(size)
	
func resize_elements(newSize):
	var scaled_size = newSize * Grid.TILE_SIZE
	if label:
		label._set_size(scaled_size / label.get_scale())
	if background:
		background._set_size(scaled_size)

# Restore the token to its original position
func reset_position():
	set_position(initial_position)
