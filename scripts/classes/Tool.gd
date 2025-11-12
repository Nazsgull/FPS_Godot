extends Equippable
class_name  Tool

var tool 

func _init(new_tool:Messenger.ToolTypes):
	tool = new_tool

func get_tool() -> Messenger.ToolTypes:
	
	return tool
