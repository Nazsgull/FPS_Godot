extends Node3D
@onready var pivot = $pivot

var equippables:Array[Equippable] = []
var currently_equipped:int = 0

func add_tool(new_scene:String):
	
	var new_equippable:Equippable = Equippable.new(new_scene)
	new_equippable.set_is_working(false)
	equippables.append(new_equippable)
	var scene_loaded = load(new_equippable.scene_path)
	var scene_instance = scene_loaded.instantiate()
	pivot.add_child(scene_instance)

func _tool_switching_by_input():
	if Input.is_action_just_pressed("tool_next"):
		print("next")
		#We don t have any equippables -> don't switch
		if equippables.size() == 0:
			return
		#Select next equippable
		if currently_equipped >= equippables.size():
			currently_equipped = 0
			_update_equippable_displayed()
			return
		else:
			currently_equipped += 1
			_update_equippable_displayed()
			return
	if Input.is_action_just_pressed("tool_prev"):
		print("prev")
		#We don t have any equippables -> don't switch
		if equippables.size() == 0:
			return
		#Select previous equippable
		if (currently_equipped - 1) > 0:
			currently_equipped -= 1
			_update_equippable_displayed()
			return

func _update_equippable_displayed():
	for each_equippable in equippables:
		each_equippable.set_is_working(false)
	if equippables.size()>0:
		equippables[currently_equipped-1].set_is_working(true)
	
func _process(delta):
	_tool_switching_by_input()
	_update_equippable_displayed()
	return
