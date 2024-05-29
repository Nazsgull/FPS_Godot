extends "res://scripts/classes/Interactable.gd"
@onready var audio_3d = $AudioStreamPlayer3D

func interact(body):
	super.interact(body)
	audio_3d.play()
