extends Node3D
@onready var pivot = $pivot

var equippables:Array[Equippable] = []
var currently_equipped:int = 0
var previously_equipped:int = 0
func add_tool(new_scene:String):
	var scene:Resource = load(new_scene)
	var new_equippable:Equippable = Equippable.new()
	var scene_instance = scene.instantiate()
	
	new_equippable.set_equippable_node(scene_instance)
	new_equippable.set_is_fully_constructed(true)
	
	equippables.append(new_equippable)
	
	pivot.add_child(new_equippable,false,Node.INTERNAL_MODE_BACK)
	pivot.add_child(new_equippable.get_equippable_node())
	
	
	
	
func _tool_switching_by_input():
	if Input.is_action_just_pressed("tool_next"):

		print("next")
		print(currently_equipped)
		if currently_equipped + 1 > equippables.size()-1:
			currently_equipped = equippables.size()-1
		else:
			currently_equipped += 1
	if Input.is_action_just_pressed("tool_prev"):
		print("prev")
		print(currently_equipped)
		if currently_equipped - 1 < 0:
			currently_equipped = 0
		else:
			currently_equipped -= 1

func _update_equippable_displayed():
	if equippables.size()>0:
		for each_equippable:Equippable in equippables:
			each_equippable.set_is_working(false)
		equippables[currently_equipped].set_is_working(true)
		print("[",currently_equipped,"]")
		
func _process(_delta):
	_tool_switching_by_input()
	_update_equippable_displayed()
	return
