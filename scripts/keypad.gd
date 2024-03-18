extends Node3D

signal combinacion_es_correcta
signal combinacion_es_incorrecta

@export_range(0,99999999) var combinacion_correcta:int = 0000
var combinacion_actual = 0
var digito_actual = str(combinacion_correcta).length()
var digitos_totales = str(combinacion_correcta).length()
var texto_final:String = ""
@onready var texto_en_pantalla = $vis/texto_en_pantalla
@onready var correcto = $Correcto
@onready var incorrecto = $Incorrecto
@onready var input = $Input
@onready var reset = $Reset



func _compara_combinacion():
	if combinacion_actual == combinacion_correcta:
		emit_signal("combinacion_es_correcta")
		correcto.play()
	else:
		emit_signal("combinacion_es_incorrecta")
		incorrecto.play()

func relay(num:int):
	input.play()
	combinacion_actual = combinacion_actual + num * (10^digito_actual-1)
	digito_actual = digito_actual - 1
	texto_final = str(combinacion_actual)
	for i in range(0,digitos_totales-digito_actual):
		texto_final.insert(texto_final.length()-1," _")
	
func _reset():
	reset.play()
	combinacion_actual = null
	digito_actual = str(combinacion_correcta).length()
	
func _update_screen():
	texto_en_pantalla.text = str(combinacion_actual)

func _on_boton_combinacion_reset_interacted(_body):
	_reset()
	_update_screen()

func _on_boton_combinacion_0_interacted(_body):
	relay(0)
	_update_screen()


func _on_boton_combinacion_9_interacted(_body):
	relay(9)
	_update_screen()


func _on_boton_combinacion_8_interacted(_body):
	relay(8)
	_update_screen()


func _on_boton_combinacion_7_interacted(_body):
	relay(7)
	_update_screen()


func _on_boton_combinacion_6_interacted(_body):
	relay(6)
	_update_screen()


func _on_boton_combinacion_5_interacted(_body):
	relay(5)
	_update_screen()


func _on_boton_combinacion_4_interacted(_body):
	relay(4)
	_update_screen()


func _on_boton_combinacion_2_interacted(_body):
	relay(2)
	_update_screen()


func _on_boton_combinacion_1_interacted(_body):
	relay(1)
	_update_screen()


func _on_boton_combinacion_3_interacted(_body):
	relay(3)
	_update_screen()


func _on_boton_combinacion_enter_interacted(_body):
	_compara_combinacion()
	_update_screen()
