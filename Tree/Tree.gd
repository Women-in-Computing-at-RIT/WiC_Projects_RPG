extends Node2D

func _on_HurtBox_area_entered(area):
	# Add chopping animation here 
	queue_free()
