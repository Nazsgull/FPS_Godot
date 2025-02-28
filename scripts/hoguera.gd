extends Node3D
@onready var ap_0 = $vis/AnimationPlayer_0
@onready var ap_1 = $vis/AnimationPlayer_1
@onready var ap_2 = $vis/AnimationPlayer_2
@onready var ap_3 = $vis/AnimationPlayer_3
@onready var sound_player = $sound/sound_player

# Called when the node enters the scene tree for the first time.
func _ready():
	ap_0.play("giros")
	ap_1.play("giros")
	ap_2.play("giro_2")
	ap_3.play("giro")
	
	#sound_player.play()


func _on_area_3d_interacted(body):
	printerr("Funciona")
