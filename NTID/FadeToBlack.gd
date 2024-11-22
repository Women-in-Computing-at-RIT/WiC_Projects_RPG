extends CanvasLayer

onready var fade_scene = $AnimationPlayer


func transition():
	visible = true;
	fade_scene.play("fade_to_black")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		fade_scene.play("fade_from_black")
		
