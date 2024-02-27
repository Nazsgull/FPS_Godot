extends Interactable

@onready var keypad_body = get_parent()
@onready var label_3d = $"../Label3D"
@export var num_string:String = "0"

func _init():
	label_3d.text = num_string


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func interact(body):
	super.emit_signal("interacted", body)
	
