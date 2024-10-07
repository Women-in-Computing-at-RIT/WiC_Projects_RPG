extends KinematicBody2D

class_name AxisAlignedBody2D

export var collider_size = Vector2.ONE
export var is_movable = true

var ray: RayCast2D

func _ready():
	position = position.snapped(Vector2.ONE * Properties.TILE_SIZE)
	add_collider()
	add_ray()

func has_collider() -> bool:
	return collider_size.x != 0 and collider_size.y != 0

func add_ray():
	if not is_movable or not has_collider():
		return
		
	ray = RayCast2D.new()
	
	var cast = collider_size * (Properties.TILE_SIZE / 2)
	var transform = Transform2D(0, cast)
	
	ray.set_transform(transform)
	ray.set_enabled(true)
	cast_ray(Vector2(0, Properties.TILE_SIZE))
	
	add_child(ray)

func add_collider():
	if not has_collider():
		return
		
	var collider = CollisionShape2D.new()
	var rect = RectangleShape2D.new()
	rect.extents = collider_size * (Properties.TILE_SIZE / 2)
	collider.shape = rect
	
	collider.position = rect.extents
	add_child(collider)

# Re-casts the direction ray, if it exists, according to a motion vector and the collider size.
# motion - a vector multiple of TILE_SIZE
func cast_ray(motion: Vector2):
	if ray == null:
		return
		
	var cast = Vector2(motion.x * collider_size.x, motion.y * collider_size.y)
	ray.set_cast_to(cast)
	ray.force_raycast_update()
	
func is_ray_colliding(): 
	return ray != null and ray.is_colliding()
