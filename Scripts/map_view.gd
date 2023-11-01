class_name MapView
extends DirectionNode

@export var level: MapBuilder
@export var viewer: Node2D
@export var top_left: Marker2D
@export var bottom_right: Marker2D
@export var view_square: PackedScene
@export var player_marker: Node2D
@export var map_root: Node2D

var _square_size: float
var _anchor: Vector2
var _squares: Array[MapViewSquare]

func _ready():
	viewer.visible = false
	_squares = []
	_squares.resize(level.width * level.height)
	_squares.fill(null)
	_calculate_square_size()

func _process(_delta):
	if Input.is_action_just_pressed("View Map"): viewer.visible = !viewer.visible
	if Input.is_action_just_pressed("Menu Back") and viewer.visible: viewer.visible = false

func _on_player_move(pos: Vector3, dir: Direction):
	var map_pos := as_vector2(pos)
	_add_square(map_pos)
	_evaluate_line(pos, dir, 3, true, true)
	_update_player_marker(map_pos, dir)

func _evaluate_line(pos: Vector3, dir: Direction, count: int, attempt_left: bool = false, attempt_right: bool = false):
	if count == 0 or !level.can_move(pos, dir): return
	var next_pos := pos + vector_of(dir)
	_add_square(as_vector2(next_pos))
	_evaluate_line(next_pos, dir, count - 1)

	if attempt_left and level.can_move(next_pos, left_of(dir)):
		var left_pos := next_pos + vector_of(left_of(dir))
		_add_square(as_vector2(left_pos))
		_evaluate_line(left_pos, dir, count - 1, true, false)

	if attempt_right and level.can_move(next_pos, right_of(dir)):
		var right_pos := next_pos + vector_of(right_of(dir))
		_add_square(as_vector2(right_pos))
		_evaluate_line(right_pos, dir, count - 1, false, true)

func _add_square(pos: Vector2i):
	var index = pos.x + pos.y * level.width
	if _squares[index] != null: return
	var square := view_square.instantiate() as MapViewSquare
	map_root.add_child(square)
	_squares[index] = square
	var tile := level.tiles[index]
	for dir in 4:
		square.set_open(dir) if tile.is_open(dir) else square.set_closed(dir)
	square.position = _anchor + Vector2(pos.x * _square_size, pos.y * _square_size)

func _update_player_marker(pos: Vector2i, dir: Direction):
	player_marker.position = _anchor + Vector2((0.5 + pos.x) * _square_size, (0.5 + pos.y) * _square_size)
	player_marker.rotation = -angle_of(dir)

func _calculate_square_size():
	var view_size := bottom_right.position - top_left.position
	var square_width := view_size.x / level.width
	var square_height := view_size.y / level.height
	_square_size = minf(square_width, square_height)
	var view_diff := view_size - Vector2(square_width * level.width, square_height * level.height)
	_anchor = top_left.position + view_diff
	map_root.scale = Vector2(_square_size / 32, _square_size / 32)
	_square_size *= 0.9
