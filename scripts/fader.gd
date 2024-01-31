extends Control
@onready var anim = $AnimationPlayer

func play(direction:bool):
	if direction:
		anim.play("fade")
	else:
		anim.play_backwards("fade")
