class_name Interactable
extends Area3D
signal interacted(body)

@export var hover_message = "Interact"
@export var intended_action = "interact"
@export var signal_s = "interacted"

func get_prompt():
	var key_name = ""
	for action in InputMap.action_get_events(intended_action):
		if action is InputEventKey:
			key_name = action.as_text_physical_keycode()
	return hover_message + "\n["+key_name+"]"


func interact(body):
	emit_signal(signal_s, body)
	print("* Player interacted with ", name)
	print("* "+name+ " emitted signal "+ "[" + interacted.get_name() + "]")
	
