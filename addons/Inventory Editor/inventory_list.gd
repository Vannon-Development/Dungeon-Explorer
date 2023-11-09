@tool
class_name InventoryList extends Control

signal item_selected(item: Dictionary)

@export var list: Tree
@export var file: JSON
@export var category_menu: PopupMenu
@export var item_menu: PopupMenu

var _data: Array

func _enter_tree():
	_data = file.data
	_build_list()

func _build_list():
	list.clear()
	var root = list.create_item()
	for category in EquipmentData.type_list:
		var cat = list.create_item(root)
		cat.set_text(0, EquipmentData.type_list[category])
		cat.set_selectable(0, false)
		cat.set_meta("cat", category)
		for item in _data:
			if item["type"] == category:
				var list_item = list.create_item(cat)
				list_item.set_text(0, item["name"])
				list_item.set_meta("id", item["id"])

func _on_list_item_selected():
	var item = list.get_selected()
	var sel = item.get_meta("id", -1)
	if sel != -1:
		item_selected.emit(_get_item(sel))

func _get_item(id: int) -> Dictionary:
	for item in _data:
		if item["id"] == id:
			return item
	return {"id": -1}

func update_item(item: Dictionary):
	for index in _data.size():
		if _data[index]["id"] == item["id"]:
			_data[index] = item
	file.data = _data
	_build_list()

func _input(event):
	if event is InputEventMouseButton and list.get_global_rect().has_point(get_global_mouse_position()) and list.is_visible_in_tree():
		var evt := event as InputEventMouseButton
		if evt.button_index == MOUSE_BUTTON_RIGHT and evt.is_pressed():
			var pos = list.get_local_mouse_position()
			var sel_item := list.get_item_at_position(pos)
			if sel_item == null: return
			if sel_item.has_meta("id"):
				var item_id: int = sel_item.get_meta("id")
				_show_item_menu(item_id)
			elif sel_item.has_meta("cat"):
				var cat_id: int = sel_item.get_meta("cat")
				_show_category_menu(cat_id)

func _name_of_category(id: int) -> String:
	for item in EquipmentData.type_list:
		if item == id: return EquipmentData.type_list[item]
	return ""

func _show_category_menu(id: int):
	category_menu.position = get_global_mouse_position()
	category_menu.set_item_text(0, "Create %s" % _name_of_category(id))
	category_menu.set_meta("cat", id)
	category_menu.popup()

func _show_item_menu(id: int):
	item_menu.position = get_global_mouse_position()
	var item = _get_item(id)
	if item["id"] == -1: return

	item_menu.set_item_text(0, "Create %s" % _name_of_category(item["type"]))
	item_menu.set_item_text(1, "Delete %s" % item["name"])
	item_menu.set_meta("cat", item["type"])
	item_menu.set_meta("item", id)
	item_menu.popup()

func _get_next_id() -> int:
	var high = -1
	for item in _data:
		if item["id"] > high: high = item["id"]
	return high + 1

func _on_category_menu_item(index: int):
	var cat: int = category_menu.get_meta("cat", 0)
	if index == 0: _create_item(cat)

func _on_item_menu_item(index: int):
	var cat: int = category_menu.get_meta("cat", 0)
	var item: int = item_menu.get_meta("item", -1)
	if index == 0: _create_item(cat)
	elif index == 1: _delete_item(item)

func _create_item(category: int):
	var item: Dictionary = {"id": _get_next_id(), "name": "New %s" % _name_of_category(category), "type": category}
	_data.append(item)
	update_item({"id": -1})
	item_selected.emit(item)

func _delete_item(item: int):
	for index in _data.size():
		if _data[index]["id"] == item:
			_data.remove_at(index)
			break
	update_item({"id": -1})
	item_selected.emit({"id": -1})
