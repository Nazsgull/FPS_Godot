extends Node3D
signal combinacion_es_correcta
signal combinacion_es_incorrecta

@export_range(0,99999999) var combinacion_correcta:int = 0000
var combinacion_actual = ""
var digito_actual = str(combinacion_correcta).length()
var digitos_totales = str(combinacion_correcta).length()
@onready var texto_en_pantalla = $vis/texto_en_pantalla
@onready var correcto = $Correcto
@onready var incorrecto = $Incorrecto
@onready var input = $Input
@onready var reset = $Reset
@onready var indicador = $vis/indicador

func _ready():
	_stealth_reset()
	
func _compara_combinacion():
	if combinacion_actual == "":
		return
	if int(combinacion_actual) == combinacion_correcta:
		emit_signal("combinacion_es_correcta",1)
		correcto.play()
		_show_correct()
	else:
		_reset()
		emit_signal("combinacion_es_incorrecta",1)
		incorrecto.play()
		_show_incorrect()

func _show_correct():
	indicador.material = preload("res://assets/materials/green_glowy.tres")
	
func _show_incorrect():
	
	indicador.material = preload("res://assets/materials/red_glowy.tres")
	
	#Quitar el 0 al principio
	#Limitar dígitos máximos
	#Permitir combinaciones que empiecen por 0
	
	
func relay(num:int):
	
	if digito_actual > 0:
		input.play()
		combinacion_actual = combinacion_actual + str(num)
		digito_actual = digito_actual - 1
	else:
		return

func _stealth_reset():
	combinacion_actual = ""
	texto_en_pantalla.text = ""
	digito_actual = str(combinacion_correcta).length()
	
func _reset():
	reset.play()
	_stealth_reset()
	
func _update_screen():
	texto_en_pantalla.text = str(combinacion_actual)
	

func _on_boton_combinacion_reset_interacted(_body):
	_reset()

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
	_stealth_reset()
