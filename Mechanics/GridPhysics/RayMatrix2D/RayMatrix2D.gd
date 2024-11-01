extends Node2D
class_name RayMatrix2D

export var size: Vector2 = Vector2.ONE
var rays = {}

func _init(size: Vector2):
	self.size = size
	for x in range(0, size.x):
		for y in range(0, size.y):
			_add_ray(Vector2(x, y)) 

func _ready():
	pass

# Add a ray for the matrix index (x, y)
func _add_ray(index: Vector2):
	var ray = Ray2D.new()
	
	# Relative position is the index <[0, size.x); [0, size.y)> scaled by
	# the tile size, plus half of the tile size in both axes (to center it).
	var relative = (index * GridProperties.TILE_SIZE) + (Vector2.ONE * (GridProperties.TILE_SIZE / 2))
	ray.set_relative_position(relative)
	
	# Rays point down by default
	var offset = Vector2(0, 1) * GridProperties.TILE_SIZE
	ray.set_cast_offset(offset)
	
	ray.set_enabled(true)
	
	self.rays[index] = ray
	add_child(ray)
		
func get_ray(index: Vector2) -> Ray2D:
	return self.rays[index]
	
# Adjusts the rays to point in the direction specified by a scaled motion vector.
func cast_all_by_motion(vector: Vector2):
	for ray in self.rays.values():
		ray.set_cast_offset(vector)

# Expresses whether any of the rays in the matrix are colliding with other objects.
func has_any_collisions() -> bool:
	for ray in self.rays.values():
		if ray.is_colliding():
			return true
			
	return false

# Provides an array containing all of the unique objects that rays in the matrix
# are currently colliding with.
func get_all_colliding_objects() -> Array:
	var objects = []
	
	for ray in self.rays.values():
		var obj = ray.get_colliding_object()
		if obj != null and not obj in objects:
			objects.append(obj)
	
	return objects
	
func add_excluded_object(obj: Object):
	for ray in self.rays.values():
		ray.add_excluded_object(obj)
