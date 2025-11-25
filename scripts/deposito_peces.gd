extends "res://scripts/classes/Interactable.gd"


signal ADD_1_FISH


func _ready():
	pass

func _physics_process(_delta):
	pass


func _on_interacted(_body):
	emit_signal("ADD_1_FISH","fish")
	Messenger.emit_signal("REMOVE_1_FISH")
