class_name MainMenu extends Node

@export var menu_items: Array[MenuLabel]

enum Selection { create, start, cont }

var _selected: Selection = Selection.create

func _ready():
	_update_visual()

func _input(event: InputEvent):
	if event.is_action_pressed("Menu Down"):
		var sel = _selected + 1
		if sel >= Selection.size(): sel = 0
		_selected = sel as Selection
		_update_visual()
	elif event.is_action_pressed("Menu Up"):
		var sel = _selected - 1
		if sel < 0: sel = Selection.size() - 1
		_selected = sel as Selection
		_update_visual()
	elif event is InputEventMouseButton:
		var evt := event as InputEventMouseButton
		if evt.button_index == MOUSE_BUTTON_LEFT and evt.is_pressed():
			var pos = evt.global_position
			for index in Selection.size():
				if menu_items[index].get_global_rect().has_point(pos):
					_run_menu(index)
	elif event.is_action_pressed("Menu Select"):
		_run_menu(_selected)

func _select_create():
	_selected = Selection.create
	_update_visual()

func _select_start():
	_selected = Selection.start
	_update_visual()

func _select_continue():
	_selected = Selection.cont
	_update_visual()

func _update_visual():
	for item in Selection.size():
		menu_items[item].set_selected(_selected == item)

func _run_menu(sel: Selection):
	if sel == Selection.create: print("Create Character")
	elif sel == Selection.start:
		var scene = preload("res://Objects/test_game_level.tscn").instantiate()
		add_sibling(scene)
		queue_free()
	elif sel == Selection.cont: print("Continue Game")
