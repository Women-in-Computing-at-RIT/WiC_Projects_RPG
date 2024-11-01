extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var collision_shape_2d = $CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func activateCollision():
	get_node("CollisionShape2D").set_deferred("disabled", false)
