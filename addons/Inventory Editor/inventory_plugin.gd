@tool
class_name InventoryPlugin extends EditorPlugin

const MainScreen = preload("res://addons/Inventory Editor/inventory_editor.tscn")
var main_screen

func _enter_tree():
	main_screen = MainScreen.instantiate()
	get_editor_interface().get_editor_main_screen().add_child(main_screen)
	_make_visible(false)

func _exit_tree():
	if main_screen:
		main_screen.queue_free()

func _has_main_screen():
	return true

func _make_visible(visible):
	if main_screen:
		main_screen.visible = visible

func _get_plugin_name():
	return "Inventory Manager"
