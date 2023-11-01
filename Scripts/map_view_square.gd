class_name MapViewSquare
extends Node2D

@export var north_line: Node2D
@export var south_line: Node2D
@export var east_line: Node2D
@export var west_line: Node2D

func set_open(dir: DirectionNode.Direction):
	_get_wall(dir).visible = false

func set_closed(dir: DirectionNode.Direction):
	_get_wall(dir).visible = true

func _get_wall(dir: DirectionNode.Direction) -> Node2D:
	if dir == DirectionNode.Direction.north: return north_line
	if dir == DirectionNode.Direction.south: return south_line
	if dir == DirectionNode.Direction.east: return east_line
	return west_line
