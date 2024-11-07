extends Node2D

func _on_RedPressurePlate_body_entered(body):
	if(body.get_name() == "Player"):
		$YSort/Widget.visible = false

func _on_RedPressurePlate_body_exited(body):
	if(body.get_name() == "Player"):
		$YSort/Widget.visible = true