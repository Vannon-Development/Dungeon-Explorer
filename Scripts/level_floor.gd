class_name LevelFloor
extends DirectionNode

@export var base_tile: PackedScene

enum TileType { empty, floor, start }

var width: int = 12
var height: int = 12
var map: Array[int] = [
	0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
	0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0,
	0, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 0,
	0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0,
	1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0,
	0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0,
	0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0,
	0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1,
	0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0,
	0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0,
	0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0
]

var _tiles: Array[MapTile]

func start_position() -> Vector3:
	for index in width * height:
		if map[index] == 2:
			return Vector3(index % width, 0, int(index / float(width)))
	print("Invalid Map: No Start Position")
	return Vector3.ZERO

func can_move(from: Vector3, dir: Direction) -> bool:
	var target: Vector3 = from + vector_of(dir)
	var map_target: Vector2i = Vector2i(int(target.x), int(target.z))
	return _exists(map_target) and _tile(map_target) != TileType.empty

func tile_at(pos: Vector2i) -> MapTile:
	return _tiles[pos.x + pos.y * width]

func _ready():
	if map.size() != width * height:
		print("Invalid Map: %i x %i = %i" % [width, height, map.size()])
		return

	_tiles = []
	_tiles.resize(width * height)
	_tiles.fill(null)
	for y in height:
		for x in width:
			var tile_type: TileType = _tile(Vector2i(x, y))
			if tile_type != TileType.empty:
				var tile := base_tile.instantiate() as MapTile
				tile.position = Vector3(x, 0, y)
				if _exists(Vector2i(x, y-1)) and _tile(Vector2i(x, y-1)) != 0: tile.set_open(Direction.NORTH)
				if _exists(Vector2i(x, y+1)) and _tile(Vector2i(x, y+1)) != 0: tile.set_open(Direction.SOUTH)
				if _exists(Vector2i(x+1, y)) and _tile(Vector2i(x+1, y)) != 0: tile.set_open(Direction.EAST)
				if _exists(Vector2i(x-1, y)) and _tile(Vector2i(x-1, y)) != 0: tile.set_open(Direction.WEST)
				add_child(tile)
				_tiles[x + y * width] = tile

func _tile(pos: Vector2i) -> TileType:
	return map[pos.y * width + pos.x] as TileType

func _exists(pos: Vector2i) -> bool:
	return pos.x >= 0 and pos.x < width and pos.y >= 0 and pos.y < height
