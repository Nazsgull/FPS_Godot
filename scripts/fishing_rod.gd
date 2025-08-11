extends Equippable

@onready var anim_player = $anim_player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(_delta):
	if Input.is_action_just_pressed("main_action"):
		anim_player.play("swing")
		
	if Input.is_action_just_released("main_action"):
		anim_player.play("launch")

		
