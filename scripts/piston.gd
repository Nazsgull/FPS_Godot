extends Node3D
@onready var anim_player = $AnimationPlayer

func _extender():
	anim_player.play("movimiento",-1,10000,false)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
