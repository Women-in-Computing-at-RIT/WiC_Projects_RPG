extends Node2D



func _on_RedPressurePlate_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if(body.get_name() == "Player"):
		$YSort/Widget.visible = false
		



func _on_RedPressurePlate_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if(body.get_name() == "Player"):
		$YSort/Widget.visible = true

