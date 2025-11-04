extends Equippable
var paused = false
#Creo esto para luego poder llamarlo al conectar las señales a esos métodos
var _callable_pause = Callable(self,"handle_pause")
var _callable_unpause = Callable(self,"handle_unpause")

var cebo_scene = preload("res://scenes/objects/wary_waters/cebo.tscn")

@onready var anim_player_cana = $anim_player_cana
@onready var anim_player_carrete = $anim_player_carrete
@onready var timer = $Timer_anim
@onready var timer_fuerza_mult = $Timer_fuerza_mult
@onready var marker_3d = $Marker3D
@onready var player = Messenger.player

var fuerza_mult = 1
var force_base = -3
var upDirection = 3.5
var canThrow = true



# Called when the node enters the scene tree for the first time.
# Conecto las señales a los métodos (declarados arriba)
func _ready():
	Messenger.connect("PAUSED",_callable_pause,2)
	Messenger.connect("UNPAUSED",_callable_unpause,2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func handle_pause():
	paused = true

func handle_unpause():
	paused = false

func _physics_process(_delta):
	if !paused:
		if Input.is_action_just_pressed("main_action") and canThrow:
			anim_player_cana.play("swing")
			timer_fuerza_mult.start()
			
		
		if Input.is_action_just_released("main_action") and canThrow:
			anim_player_cana.play("launch")
			anim_player_carrete.play("carrete")
			canThrow = false
			_cebo_launch()
			timer_fuerza_mult.stop()
			timer.start()

func _cebo_launch():
	var cebo_ins = cebo_scene.instantiate()
	cebo_ins.position = marker_3d.get_global_position()
	get_tree().current_scene.add_child(cebo_ins)
	var playerRotation = player.get_global_transform().basis.z.normalized()
	#Lanza el cebo con más fuerza cuanto más se aguante el ratón.
	cebo_ins.apply_central_impulse(playerRotation * force_base * fuerza_mult + Vector3(0,upDirection,0))
	fuerza_mult = 1

func _on_timer_timeout():
	anim_player_carrete.stop(true)
	canThrow = true

#Aumenta la fuerza de lanzamiento cada vez que se acaba el tiempo del timer_fuerza_mult
func _on_timer_fuerza_mult_timeout():
	timer_fuerza_mult.start()
	
	if fuerza_mult < 16:
		fuerza_mult = fuerza_mult + 1;
		printerr(fuerza_mult)
		return
	return
