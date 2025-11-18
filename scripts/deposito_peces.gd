extends "res://scripts/classes/Interactable.gd"


signal ADD_1_FISH


func _ready():
	pass

func _physics_process(_delta):
	pass


func _on_interacted(body):
	emit_signal("ADD_1_FISH","fish")
