extends StaticBody2D


onready var animated_sprite = $AnimatedSprite



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func activateCollision():
	get_node("hitbox").set_deferred("disabled", false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
