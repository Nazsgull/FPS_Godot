extends Node3D
class_name Equippable

var is_working:bool = false
var is_fully_constructed = false
var node
var tool_type : Messenger.ToolTypes

func set_tool_type(nuevo_tipo:Messenger.ToolTypes):
	tool_type = nuevo_tipo
	return true

func get_tool_type() -> Messenger.ToolTypes:
	return tool_type

func set_is_working(new_is_working:bool) -> void:
	is_working = new_is_working

func get_is_working() -> bool:
	return is_working

func set_equippable_node(new_node) -> void:
	node = new_node

func get_equippable_node() -> Node3D:
	return node

func set_is_fully_constructed(new_is_fully_constructed:bool) -> void:
	is_fully_constructed = new_is_fully_constructed

func _check_working() -> void:
	if is_working:
		node.show()
		node.set_process_input(true)
	else:
		node.hide()
		node.set_process_input(false)

func _process(_delta):
	if is_fully_constructed:
		_check_working()
