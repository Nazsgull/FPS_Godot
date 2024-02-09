extends Node3D

var equippables:Array[Equippable] = []
var currently_equipped:int = 0

func add_tool(new_equippable:Equippable):
	var loading_equippable = new_equippable.load()
	var new_equippable_instance:PackedScene = loading_equippable.instantiate()
	
	equippables.append(new_equippable_instance)

func _tool_switching_by_input():
	if Input.is_action_just_pressed("tool_next"):
		#We don t have any equippables -> don't switch
		if equippables.size() == 0:
			return
		#Select next equippable
		if (currently_equipped + 1) > equippables.size():
			currently_equipped = 0
			_update_equippable_displayed()
			return
		else:
			currently_equipped += 1
			_update_equippable_displayed()
			return
	if Input.is_action_just_pressed("tool_prev"):
		#We don t have any equippables -> don't switch
		if equippables.size() == 0:
			return
		#Select previous equippable
		if (currently_equipped - 1) < 0:
			currently_equipped = equippables.size()-1
			_update_equippable_displayed()
			return

func _update_equippable_displayed():
	for each_equippable in equippables:
		each_equippable.set_is_working(false)
	equippables[currently_equipped].set_is_working(true)
	
func _process(delta):
	_tool_switching_by_input()
	return
