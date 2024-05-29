extends "res://scripts/button.gd"
@onready var animation_player = $AnimationPlayer
@onready var audio_stream_player_3d = $AudioStreamPlayer3D

func interact(body):
	super.interact(body)
	animation_player.play("press")
