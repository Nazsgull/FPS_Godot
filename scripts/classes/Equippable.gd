extends Node3D
class_name Equippable

var is_working:bool = false

func set_is_working(new_is_working:bool):
	print("(SET)[is_working] = ",new_is_working)
	is_working = new_is_working

func get_is_working():
	print("(GET)[is_working]")
	return is_working

func _switch_working():
	if is_working:
		self.show()
		set_process_input(true)
	else:
		self.hide()
		set_process_input(false)

func _process(delta):
	_switch_working()
