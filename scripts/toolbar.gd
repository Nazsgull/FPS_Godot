extends Node3D

var equippables = []
var currently_equipped:int = 0

func add_tool(new_equippable:Equippable):
	var loading_equippable = new_equippable.load()
	var new_equippable_instance:PackedScene = loading_equippable.instantiate()
	
	equippables.append(new_equippable_instance.instantiate())
	
 
func _physics_process(delta):
	if Input.is_action_just_pressed("tool_next"):
		currently_equipped += 1
		return
	if Input.is_action_just_pressed("tool_prev"):
		return
		currently_equipped -= 1
	return
