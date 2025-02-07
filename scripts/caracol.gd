extends CharacterBody3D
@onready var nav = $NavigationAgent3D
@export var SPEED = 1.35

@onready var caracol_1 = $caracol1

func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	velocity = new_velocity
	move_and_slide()
	caracol_1.look_at(next_location)
	
func update_target_location(new_target_location):
	nav.target_position = new_target_location 


func _on_visible_on_screen_notifier_3d_screen_entered():
	SPEED = .1
	printerr(SPEED)

func _on_visible_on_screen_notifier_3d_screen_exited():
	SPEED = 4
	
	printerr(SPEED)
