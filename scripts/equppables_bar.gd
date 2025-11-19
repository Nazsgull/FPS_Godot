extends Node3D
@onready var pivot = $pivot

@export var equippables:Array[Equippable] = [] #Aparece como vacío en el inspector ???
var currently_equipped:int = 0
var previously_equipped:int = 0

func add_tool(new_scene:String,tipo:Messenger.ToolTypes):

	var scene:Resource = load(new_scene)
	var new_equippable:Equippable = Equippable.new()
	var scene_instance = scene.instantiate()
	

	new_equippable.set_equippable_node(scene_instance) #->NULL!!
	new_equippable.set_is_fully_constructed(true)
	
	equippables.append(new_equippable)
	
	pivot.add_child(new_equippable,false,Node.INTERNAL_MODE_BACK)
	pivot.add_child(new_equippable.get_equippable_node())
	

func _tool_switching_by_input():
	if Input.is_action_just_pressed("tool_next"):
		switch_next_tool()

	if Input.is_action_just_pressed("tool_prev"):
		switch_prev_tool()

func switch_next_tool():
	print("next")
	print(currently_equipped)
	previously_equipped = currently_equipped
	if there_is_NO_next_tool():
		currently_equipped = equippables.size()-1
	else:
		currently_equipped += 1

func there_is_NO_next_tool() -> bool:
	return currently_equipped + 1 > equippables.size()-1
	
	
func switch_prev_tool():
	print("prev")
	print(currently_equipped)
	previously_equipped = currently_equipped
	if there_is_NO_prev_tool():
		currently_equipped = 0
	else:
		currently_equipped -= 1
	
func there_is_NO_prev_tool():
	return currently_equipped - 1 < 0
	
func _update_equippable_displayed():
	if equippables.size()>0:
		for each_equippable:Equippable in equippables:
			each_equippable.set_is_working(false)
		equippables[currently_equipped].set_is_working(true)
		#print("[",currently_equipped,"]")
		
func _process(_delta):
	_tool_switching_by_input()
	_update_equippable_displayed()
	return

#Elimina la primera instancia que encuentre de "type_to_remove" en "equippables"
func remove_1_caught_fish():
	print("Se ha intentado eliminar 1 pez")
	for i in equippables:
		if i.get_tool_type()==Messenger.ToolTypes.CAUGHT_FISH:
			currently_equipped = previously_equipped
		
			equippables[i].get_equippable_node().queue_free()
			equippables.erase(i)
			
	return
