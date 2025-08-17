extends Node3D

@onready var piston = $Piston
@onready var fish_bank = $Fish_bank

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_gestor_tiempo_ha_pasado_un_dia():
	fish_bank.day_pass()	
