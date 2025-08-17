extends Node3D
@onready var anim_player = $AnimationPlayer
var estado = false
func extender_retraer():
	anim_player.play("movimiento")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_fancy_interacted(body):
	extender_retraer()
	pass # Replace with function body.


func _on_timer_timeout():
	pass # Replace with function body.
