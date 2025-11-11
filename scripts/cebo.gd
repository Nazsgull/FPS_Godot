extends RigidBody3D
@onready var animation_player = $AnimationPlayer

var player = Messenger.player
var lanzado = false
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("sea_wobble_normal")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

#Pica un pez
func _on_timer_timeout():
	player.fishingmode_anim_player.play("fishingmode_inout",-1,-1,true)
	player.isFishing = false
