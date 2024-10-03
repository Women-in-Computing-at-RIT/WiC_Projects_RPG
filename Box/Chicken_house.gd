extends KinematicBody2D
class_name Moveable

func push(velocity: Vector2) -> void:
	move_and_slide(velocity, Vector2())
