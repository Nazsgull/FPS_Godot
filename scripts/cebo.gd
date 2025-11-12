extends RigidBody3D
@onready var animation_player = $AnimationPlayer

var player = Messenger.player

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("sea_wobble_normal")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

#Pica un pez
func _on_timer_timeout():
	#if randf()< 0.5:
	var fish_scene = preload("res://scenes/objects/wary_waters/fish_pickup.tscn")
	var fish_instance = fish_scene.instantiate()
	fish_instance.position = player.get_global_position()
	get_tree().current_scene.add_child(fish_instance)
