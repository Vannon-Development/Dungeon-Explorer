@tool
class_name EquipmentSetup extends Control

signal item_changed(item: Dictionary)

@export_category("Control List")
@export var name_entry: LineEdit
@export var type_entry: OptionButton

@export var min_strength_display: Label
@export var min_strength_slider: Slider
@export var min_dexterity_display: Label
@export var min_dexterity_slider: Slider
@export var min_intelligence_display: Label
@export var min_intelligence_slider: Slider
@export var min_faith_display: Label
@export var min_faith_slider: Slider

@export var weapon_slot_entry: OptionButton

@export_category("Group List")
@export var equipment_group: Control
@export var weapon_group: Control

var _orig_item: Dictionary

func _enter_tree():
	type_entry.clear()
	for item in EquipmentData.type_list:
		type_entry.add_item(EquipmentData.type_list[item], item)

	weapon_slot_entry.clear()
	for item in EquipmentData.weapon_slot_list:
		weapon_slot_entry.add_item(EquipmentData.weapon_slot_list[item], item)

	_show_groups_for(0)

func set_item(item: Dictionary):
	_orig_item = item
	name_entry.text = item["name"] if item.has("name") else ""
	type_entry.selected = item["type"] if item.has("type") else 0
	_show_groups_for(type_entry.selected)
	min_strength_slider.value = item["min_strength"] if item.has("min_strength") else 0
	min_dexterity_slider.value = item["min_dexterity"] if item.has("min_dexterity") else 0
	min_intelligence_slider.value = item["min_intelligence"] if item.has("min_intelligence") else 0
	min_faith_slider.value = item["min_faith"] if item.has("min_faith") else 0
	weapon_slot_entry.selected = item["weapon_slot"] if item.has("weapon_slot") else 0

func _on_type_changed(index):
	_show_groups_for(index)

func _show_groups_for(type: int):
	equipment_group.visible = type == 0 or type == 1 or type == 2 or type == 4
	weapon_group.visible = type == 0

func _on_min_strength_changed(value):
	min_strength_display.text = str(value)

func _on_min_dexterity_changed(value):
	min_dexterity_display.text = str(value)

func _on_min_intelligence_changed(value):
	min_intelligence_display.text = str(value)

func _on_min_faith_changed(value):
	min_faith_display.text = str(value)

func _submit_item():
	var item: Dictionary = {"id": _orig_item["id"]}
	item["name"] = name_entry.text
	item["type"] = type_entry.selected
	if equipment_group.visible:
		if min_strength_slider.value != 0: item["min_strength"] = min_strength_slider.value
		if min_dexterity_slider.value != 0: item["min_dexterity"] = min_dexterity_slider.value
		if min_intelligence_slider.value != 0: item["min_intelligence"] = min_intelligence_slider.value
		if min_faith_slider.value != 0: item["min_faith"] = min_faith_slider.value
	if weapon_group.visible:
		item["weapon_slot"] = weapon_slot_entry.selected
	item_changed.emit(item)

func _on_save_press():
	_submit_item()

func _on_revert_press():
	set_item(_orig_item)
