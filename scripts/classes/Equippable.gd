extends Node3D
class_name Equippable

var is_working:bool = false
var node:Node3D

func _init(new_node:Node3D):
	node = new_node
	
	
func set_is_working(new_is_working:bool):
	is_working = new_is_working

func get_is_working():
	return is_working

func _check_working():
	if is_working:
		node.show()
		node.set_process_input(true)
	else:
		node.hide()
		node.set_process_input(false)

func _process(_delta):
	_check_working()
