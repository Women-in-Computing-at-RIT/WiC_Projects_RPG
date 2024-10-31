
# AxisAlignedBody2D

**This is the node class you should extend in order to create a movable object**

A `KinematicBody2D` whose position and movement are fixed to an underlying grid (16x16).
A `RayMatrix2D` and `CollisionShape2D` are generated automatically based on the `collider_size`.

## collider_size
A `Vector2` for the size of the body in grid tiles. (`width`, `height`)

## is_movable
Whether the body can be moved by pushing.

# RayMatrix2D

An axis-aligned matrix of `Ray2D`. Used to enable collisions between `AxisAlignedBody2D` that occupy multiple grid tiles.

## size
A `Vector2` representing the (`width`, `height`) of the matrix in grid tiles.

## Ray2D

A wrapper for `RayCast2D`. Provides some extra utilites for managing the raycast.

# GridPlayer
An implementation of the player based on `AxisAlignedBody2D`. The player is fixed to a tile grid and can push other `AxisAlignedBody2D` nodes (provided they set `is_movable` to true).