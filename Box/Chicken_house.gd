extends KinematicBody2D
class_name Moveable


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func push(velocity: Vector2) -> void:
	move_and_slide(velocity, Vector2())
