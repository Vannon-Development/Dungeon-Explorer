@tool
class_name InventoryEditor extends Control

@export var list_screen: InventoryList
@export var detail_screen: EquipmentSetup

func _on_item_selected(item: Dictionary):
	detail_screen.set_item(item)

func _on_item_changed(item):
	list_screen.update_item(item)
