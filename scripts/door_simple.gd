extends Node3D

@onready var anim = $AnimationPlayer


@export var open = false
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
