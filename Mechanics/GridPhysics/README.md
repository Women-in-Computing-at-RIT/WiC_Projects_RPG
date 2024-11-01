
# Creating a Grid-Aligned Pushable Object


# Structure

## GridProperties

An autoloaded script that defines the `TILE_SIZE`.

## AxisAlignedBody2D

A `KinematicBody2D` whose position and movement are fixed to an underlying grid (16x16).
A `RayMatrix2D` and `CollisionShape2D` are generated automatically based on the `collider_size`.

#### Properties

`collider_size: Vector2`

The size of the body in grid tiles. (`width`, `height`)

`is_movable: bool`

Whether the body can be moved by pushing.

## RayMatrix2D

An axis-aligned matrix of `Ray2D`. Used to enable collisions between `AxisAlignedBody2D` that occupy multiple grid tiles.

#### Properties

`size: Vector2`

The size of the matrix in grid tiles (`width`, `height`).

## Ray2D

A wrapper for `RayCast2D`. Provides some extra utilites for managing the raycast.

## GridPlayer
An implementation of the player based on `AxisAlignedBody2D`. The player is fixed to a tile grid and can push other `AxisAlignedBody2D` nodes (provided they set `is_movable` to true).