extends Node3D
@onready var timer = $Timer
signal ha_pasado_un_dia

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	emit_signal("ha_pasado_un_dia")
	print("HA PASADO UN DÍA")
