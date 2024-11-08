extends Area2D




# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var item_name = "key" # Name of the item (e.g., "Health Potion", "Gold Coin")


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_body_entered") # Replace with function body.
	

func _on_body_entered(body):
	# Check if the body that entered is the player
	if body.is_in_group("players"):
		queue_free()  # Remove item from scene


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



