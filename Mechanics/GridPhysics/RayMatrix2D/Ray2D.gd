extends Node2D
class_name Ray2D

var _ray: RayCast2D

func _init():
	self._ray = RayCast2D.new()
	add_child(self._ray)

# Enable or disable the ray.
func set_enabled(enabled: bool):
	self._ray.set_enabled(enabled)
	
func add_excluded_object(obj: Object):
	self._ray.add_exception(obj)

# Adjusts the transform so the ray will be at the position given relative to
# its parent node.
func set_relative_position(pos: Vector2):
	var transform = Transform2D(0, pos)
	self._ray.set_transform(transform)
	
# Adjusts the ray so it will be cast to its position (as set using 
# set_relative_position) plus the given offset vector.
func set_cast_offset(offset: Vector2):
	self._ray.set_cast_to(offset)
	self._ray.force_raycast_update()

# Expresses whether the ray is colliding with anything.
func is_colliding() -> bool:
	return self._ray.is_colliding()

# Provides the object that the ray is colliding with.
func get_colliding_object() -> Object:
	return self._ray.get_collider()
