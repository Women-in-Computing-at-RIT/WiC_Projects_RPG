
extends Area2D

signal on_plate_entered
signal on_plate_exited

onready var body = $AxisAlignedBody2D

func _ready():
	add_child(body.create_collider())
	pass

