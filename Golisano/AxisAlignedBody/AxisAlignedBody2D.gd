extends KinematicBody2D

class_name AxisAlignedBody2D

func _ready():
	position = position.snapped(Vector2.ONE * Properties.TILE_SIZE)
