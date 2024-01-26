extends Node3D
class_name Door

@onready var anim = $AnimationPlayer

@export var open:bool = false
func _ready():
	if open:
		open = false
		anim.play("open")
			
		return
	else:
		open = true
		anim.play_backwards("open")
		return

func toggle_door(_body) -> void:
	if open:
		open = false
		anim.play("open")
		return
	open = true
	anim.play_backwards("open")
	return
