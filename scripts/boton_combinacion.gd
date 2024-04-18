extends "res://scripts/classes/Interactable.gd"

@onready var label = $Label3D


#anim_player = $AnimationPlayer

@export var text = "0"

	
func _ready():
	label.text = text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
