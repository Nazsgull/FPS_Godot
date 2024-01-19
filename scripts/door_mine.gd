extends Node3D
@onready var anim = $door_frame/AnimationPlayer

@export var open = false

func _ready():
	if open:
		anim.play("open")
	else:
		anim.play_backwards("open")

func _toggleDoor(_body):
	open = !open
	if open:
		anim.play("open")
	else:
		anim.play_backwards("open")
