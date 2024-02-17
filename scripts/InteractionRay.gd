extends RayCast3D
@onready var label_3d = $Label3D

func _ready():
	add_exception(owner)

func _physics_process(_delta):
	if is_colliding():
		var detected = get_collider()
		
		if detected is Interactable:
			label_3d.text = detected.get_prompt()
			
			if Input.is_action_just_pressed("interact"):
				detected.interact(owner)
	else:
		label_3d.text = ""
