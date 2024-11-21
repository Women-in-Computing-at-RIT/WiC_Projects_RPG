tool
extends KinematicBody2D

class_name AxisAlignedBody2D

const GridProperties = preload("res://Mechanics/GridPhysics/GridProperties.gd")

export var collider_size = Vector2.ONE setget _on_size_changed
export var is_movable = true setget _on_is_movable_changed

var collider

# List of raycasts - one for each 'cell'
var rays: RayMatrix2D

func _ready():
	position = position.snapped(Vector2.ONE * GridProperties.TILE_SIZE)
	add_collider()
	add_rays()

# Invoked when the collider size is changed
# This should only happen from the editor via the inspector
# Ensures that the editor preview of this node will update
# when any changes are made	
func _on_size_changed(size):
	collider_size = size
	add_rays()
	add_collider()
	update()
	property_list_changed_notify()
	
func _on_is_movable_changed(is_movable_now):
	is_movable = is_movable_now
	add_rays()
	update()
	property_list_changed_notify()

func has_collider() -> bool:
	return collider_size.x != 0 and collider_size.y != 0

func add_rays():
	if not is_movable or not has_collider():
		if self.rays != null:
			remove_child(self.rays)
			self.rays.queue_free()
			self.rays = null
		return
		
	if self.rays != null:
		self.rays.queue_free()
		
	self.rays = RayMatrix2D.new(collider_size)
	self.rays.add_excluded_object(self)
	add_child(self.rays)

func create_shape():
	var rect = RectangleShape2D.new()
	rect.extents = collider_size * (GridProperties.TILE_SIZE / 2)
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
		
	if collider != null:
		remove_child(collider)
		collider.queue_free()
		
	collider = create_collider()
	add_child(collider)
