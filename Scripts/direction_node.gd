class_name DirectionNode
extends Node3D

enum Direction { NORTH, EAST, SOUTH, WEST }

var _directions: Array[Vector3] = [Vector3(0, 0, -1), Vector3(1, 0, 0), Vector3(0, 0, 1), Vector3(-1, 0, 0)]
var _angles: Array[float] = [0, -PI / 2, PI, PI / 2]

func left_of(dir: Direction) -> Direction:
	var next: int = int(dir) - 1
	if next < 0: next = 3
	return next as Direction

func right_of(dir: Direction) -> Direction:
	var next: int = int(dir) + 1
	if next > 3: next = 0
	return next as Direction

func reverse_of(dir: Direction) -> Direction:
	var next: int = int(dir) + 2
	if next > 3: next -= 4
	return next as Direction

func vector_of(dir: Direction) -> Vector3:
	return _directions[dir]

func angle_of(dir: Direction) -> float:
	return _angles[dir]

func as_vector2(pos: Vector3) -> Vector2i:
	return Vector2i(int(pos.x), int(pos.z))

func as_vector3(pos: Vector2i) -> Vector3:
	return Vector3(pos.x, 0, pos.y)
