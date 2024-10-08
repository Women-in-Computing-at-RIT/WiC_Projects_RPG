extends KinematicBody2D

class_name AxisAlignedBody2D

export var collider_size = Vector2.ONE
export var is_movable = true

# List of raycasts - one for each 'cell'
var rays: RayMatrix2D

func _ready():
	position = position.snapped(Vector2.ONE * Properties.TILE_SIZE)
	add_collider()
	add_rays()

func has_collider() -> bool:
	return collider_size.x != 0 and collider_size.y != 0

func add_rays():
	if not is_movable or not has_collider():
		return
		
	self.rays = RayMatrix2D.new(collider_size)
	self.rays.add_excluded_object(self)
	add_child(self.rays)

func add_collider():
	if not has_collider():
		return
		
	var collider = CollisionShape2D.new()
	var rect = RectangleShape2D.new()
	rect.extents = collider_size * (Properties.TILE_SIZE / 2)
	collider.shape = rect
	
	collider.position = rect.extents
	add_child(collider)
