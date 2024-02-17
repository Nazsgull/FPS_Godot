extends Node3D
var used = false
signal pickup(what_item_path:String)

@export var scene:String = "res://scenes/objects/Equippables/test_equippable.tscn"

@onready var timer = $Timer
@onready var audio_sp = $AudioStreamPlayer
@onready var player:Player = get_tree().get_nodes_in_group("player")[0]

func _on_area_3d_body_entered(_body):
	if !used:
		used = true
		audio_sp.play()
		player.handle_pickup(scene)
		timer.start()

func _on_timer_timeout():
	self.queue_free()
