extends AxisAlignedBody2D

export var label = ""

onready var background = $ColorRect

func _ready():
	background._set_size(collider_size * Properties.TILE_SIZE)
