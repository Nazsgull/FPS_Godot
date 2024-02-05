extends Node3D

signal pickup(what_item_path:PackedScene)
@onready var area_3d = $Area3D
@onready var collision_shape_3d = $Area3D/CollisionShape3D
@export var scene:PackedScene = load("res://scenes/objects/Equippables/test_equippable.tscn")


func _on_area_3d_area_entered(area):
	pickup.emit(scene)
	print("Test pickup succesful")
