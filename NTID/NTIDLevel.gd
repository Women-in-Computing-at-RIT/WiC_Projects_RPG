extends Node2D

onready var block = $Block
onready var block_2 = $Block2
onready var block_3 = $Block3

onready var blocks = [block, block_2, block_3]

func _on_Interpreter_area_entered(area):
	for b in blocks:
		b.visible = true
		b.activateCollision()
	
