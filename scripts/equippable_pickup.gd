extends Node3D

signal pickup(what_item_path:String)

@export var scene:String = "res://scenes/objects/Equippables/test_equippable.tscn"

@onready var player:Player = get_tree().get_nodes_in_group("player")[0]

func _on_area_3d_body_entered(body):
	player.handle_pickup(scene)
