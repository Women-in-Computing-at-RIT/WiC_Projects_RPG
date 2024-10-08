extends Node
class_name Ray2D

# TODO: figure out the appropriate Transform2D property to use when this is needed
#	func get_position() -> Vector2:
#		return self._ray.get_transform().get_position()

var _ray: RayCast2D
	
func _ready():
	self._ray = RayCast2D.new()
	add_child(self._ray)

# Enable or disable the ray.
func set_enabled(enabled: bool):
	self._ray.set_enabled(enabled)

## Move the ray to a new parent node.
#func set_parent(node: Node):
#	self._ray.get_parent().remove_child(self._ray)
#	node.add_child(self._ray)

# Adjusts the transform so the ray will be at the position given relative to
# its parent node.
func set_relative_position(pos: Vector2):
	var transform = Transform2D(0, pos)
	self._ray.set_transform(transform)
	
# Adjusts the ray so it will be cast to its position (as set using 
# set_relative_position) plus the given offset vector.
func set_cast_offset(offset: Vector2):
	self._ray.cast_to(offset)

# Expresses whether the ray is colliding with anything.
func is_colliding() -> bool:
	return self._ray.is_colliding()

# Provides the object that the ray is colliding with.
func get_colliding_object() -> Object:
	return self._ray.get_collider()
#
#func get_colliding_AAB2D():
#	if not self._ray.is_colliding():
#		return null
#
#	var obj = self._ray.get_collider()
#
#	return obj as AxisAlignedBody2D
