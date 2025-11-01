extends Node3D

#Lo que se obtiene eliminando enemigos
var exp_actual:int=0
#Lo que se necesita para subir de nivel
var exp_siguiente_nivel:int = calcula_exp_nivel(nivel_actual+1)

var nivel_actual:int = 1

#STATS
#Cantidad de salud
var STAT_vitalidad:int = 1

#Determina cuánto puede correr
var STAT_estamina:int = 1

#Capacidad para estabilizar el arma
var STAT_precision:int = 1

#Aumenta la distancia a la que se pueden ver los enemigos
var STAT_vision:int = 1

#Escala daño de armas a melee y protección de blindaje contra explosivos
var STAT_fuerza:int = 1

#Escala daño de armas de energía y protección de blindaje de energía
var STAT_ciencia:int = 1

#Escala daño de armas balísticas y protección de blindaje balístico
var STAT_balistica:int = 1

#Escala daño de armas glitch y protección de blindaje glitch
var STAT_cifrado:int = 1

#Mejora los objetos que aparecen en las cajas de botín
var STAT_suerte:int = 1

#Outcome
var max_HP:int = 10
var stamina_points:int = 10
var precision:float = 0.10
var vision_dist:float = 10.0
var throw_dist_max:float = 5.0
var weight_max:int = 10
var melee_dmg:float = 1.0
var laser_dmg:float = 1.0
var ballistic_dmg:float = 1.0
var cypher_dmg:float = 1.0
var luck_chance:float = 1.0


func calcula_exp_nivel(nivel:int):
	if nivel_actual < 12:
		return (0.0068 * nivel) ** 3 - (0.06 * nivel) ** 2 + 17.1 * nivel + 639
	else:
		return (0.02 * nivel) ** 3 - (3.06 * nivel) ** 2 + 105.6 * nivel - 869

func subir_nivel_actual():
	nivel_actual = nivel_actual+1
#Aumenta el nivel de una estadística
func subir_nivel_stat(stat:StringName):
	match stat:
		"STAT_precision":
			STAT_precision = STAT_precision+1
		"STAT_vitalidad":
			STAT_vitalidad = STAT_vitalidad+1
		"STAT_estamina":
			STAT_estamina = STAT_estamina+1
		"STAT_balistica":
			STAT_balistica = STAT_balistica+1
		"STAT_cifrado":
			STAT_cifrado = STAT_cifrado+1
		"STAT_ciencia":
			STAT_ciencia = STAT_ciencia+1
		"STAT_fuerza":
			STAT_fuerza = STAT_fuerza+1
		"STAT_vision":
			STAT_vision = STAT_vision+1
		"STAT_suerte":
			STAT_suerte = STAT_suerte+1



