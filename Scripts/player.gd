class_name Player extends DirectionNode

signal player_move(pos: Vector3, dir: Direction)

@export var map: LevelFloor
@export var animations: AnimationPlayer

var facing: Direction

var _attack_time: int

func _ready():
	facing = Direction.NORTH
	position = map.start_position()

var _frame1: bool = true
func _process(_delta):
	if _frame1:
		player_move.emit(position, facing)
		_frame1 = false
	if Input.is_action_just_pressed("Forward"):
		if map.can_move(position, facing):
			position += vector_of(facing)
			player_move.emit(position, facing)
	if Input.is_action_just_pressed("Back"):
		if map.can_move(position, reverse_of(facing)):
			position += vector_of(reverse_of(facing))
			player_move.emit(position, facing)
	if Input.is_action_just_pressed("Left"):
		if map.can_move(position, left_of(facing)):
			position += vector_of(left_of(facing))
			player_move.emit(position, facing)
	if Input.is_action_just_pressed("Right"):
		if map.can_move(position, right_of(facing)):
			position += vector_of(right_of(facing))
			player_move.emit(position, facing)
	if Input.is_action_just_pressed("Turn Left"):
		facing = left_of(facing)
		rotation.y = angle_of(facing)
		player_move.emit(position, facing)
	if Input.is_action_just_pressed("Turn Right"):
		facing = right_of(facing)
		rotation.y = angle_of(facing)
		player_move.emit(position, facing)
	if Input.is_action_just_pressed("Attack Primary"):
		_primary_attack()

func _primary_attack():
	if Time.get_ticks_msec() > _attack_time:
		animations.play("dagger_attack")
		_attack_time = Time.get_ticks_msec() + 2000
