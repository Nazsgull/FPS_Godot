extends "res://scripts/classes/Equippable.gd"
@onready var fish_equippable = $"."


var callable_handle_REMOVE_1_FISH = Callable(self,"handle_REMOVE_1_FISH")

func _ready():
	Messenger.REMOVE_1_FISH.connect(_handle_REMOVE_1_FISH)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _handle_REMOVE_1_FISH():
	fish_equippable.set_process(PROCESS_MODE_DISABLED)
	fish_equippable.queue_free()
	
