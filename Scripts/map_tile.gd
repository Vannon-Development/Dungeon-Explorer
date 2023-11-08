class_name MapTile
extends DirectionNode

@export var north_wall: Node3D
@export var south_wall: Node3D
@export var east_wall: Node3D
@export var west_wall: Node3D

func set_open(dir: Direction):
	_wall_at(dir).visible = false

func set_closed(dir: Direction):
	_wall_at(dir).visible = true

func is_open(dir: Direction) -> bool:
	return !_wall_at(dir).visible

func _wall_at(dir: Direction) -> Node3D:
	if dir == Direction.NORTH: return north_wall
	if dir == Direction.SOUTH: return south_wall
	if dir == Direction.EAST: return east_wall
	return west_wall
