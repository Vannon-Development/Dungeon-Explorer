class_name MenuLabel extends Label

@export var normal_color: Color
@export var selected_color: Color

var _selected: bool

func _ready():
	set_selected(false)

func set_selected(value: bool):
	_selected = value
	label_settings.font_color = selected_color if _selected else normal_color

func get_selected() -> bool:
	return _selected

func _udpate_color():
	pass
