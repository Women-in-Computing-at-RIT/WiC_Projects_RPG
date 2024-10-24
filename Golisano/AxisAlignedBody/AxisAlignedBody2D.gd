extends KinematicBody2D

class_name AxisAlignedBody2D

export var collider_size = Vector2.ONE
export var is_movable = true

var collider

# List of raycasts - one for each 'cell'
var rays: RayMatrix2D

func _ready():
	position = position.snapped(Vector2.ONE * Properties.TILE_SIZE)
	add_collider()
	add_rays()
	property_list_changed_notify()

func has_collider() -> bool:
	return collider_size.x != 0 and collider_size.y != 0

func add_rays():
	if not is_movable or not has_collider():
		return
		
	self.rays = RayMatrix2D.new(collider_size)
	self.rays.add_excluded_object(self)
	add_child(self.rays)

func create_shape():
	var rect = RectangleShape2D.new()
	rect.extents = collider_size * (Properties.TILE_SIZE / 2)
	return rect
	
func create_collider():
	var c = CollisionShape2D.new()
	var rect = create_shape()
	c.shape = rect
	c.position = rect.extents
	return c 

func add_collider():
	if not has_collider():
		return
		
	add_child(create_collider())
