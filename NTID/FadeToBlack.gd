extends CanvasLayer

onready var fade_scene = $AnimationPlayer

# fade to black transition
# author: Sydney Tsin (sst8237)
func transition():
	visible = true;
	fade_scene.play("fade_to_black")

# once animation is finished fade from black to normal
# author: Sydney Tsin (sst8237)
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		fade_scene.play("fade_from_black")
		
