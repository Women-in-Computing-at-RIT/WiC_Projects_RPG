tool
extends Node2D

const Grid = preload("res://Mechanics/GridPhysics/GridProperties.gd")

# Expected statement text
export var expected_statement = 'undefined'
var expected_tokens = []

var tokens = []

var tiles_wide = 0
var guide_rect

func get_token_nodes():
	var nodes = []
	
	var children = get_children()
	for child in children:
		var node = child as Token
		if node != null:
			nodes.append(node)
	
	print(nodes)
	
	return nodes

func _init():
	guide_rect = ColorRect.new()
	add_child(guide_rect)

func _ready():
	# Split expected statement into tokens
	expected_tokens = expected_statement.split(' ')
	
	# Aggregate child nodes (tokens)
	# Tokens by default are out of place
	tokens = get_token_nodes()
	
	# Calculate the total horizontal tiles
	for token in tokens:
		tiles_wide += token.collider_size.X
		
	guide_rect._set_size(Vector2(tiles_wide * Grid.TILE_SIZE, Grid.TILE_SIZE))
	
	# Create a rect to represent the space to fill with tokens
	pass

# Retrieve the string produced by concatenating all tokens that are
# within the statement space
func get_text():
	return ''

# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _process(delta):
	# Iterate through all child tokens
	# Skip tokens that do not overlap with the statement space
	# Sort by ascending X position
	# Check each token against the expected tokens
	# When one is out of place, recolor the rest to red and stop
	# Tokens that are partially overlapping with the space should be red also
	pass
	

