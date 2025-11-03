extends Equippable
var paused = false
#Creo esto para luego poder llamarlo al conectar las señales a esos métodos
var _callable_pause = Callable(self,"handle_pause")
var _callable_unpause = Callable(self,"handle_unpause")
@onready var anim_player = $anim_player

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
		if Input.is_action_just_pressed("main_action"):
			anim_player.play("swing")
		
		if Input.is_action_just_released("main_action"):
			anim_player.play("launch")

		
