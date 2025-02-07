extends CharacterBody3D

@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var navigation_agent_3d = $NavigationAgent3D

const SPEED = 3.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _process(delta):
	navigation_agent_3d.target_position = player.position
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y -= 2

	var next_location = navigation_agent_3d.get_next_path_position()
	var current_location = self.position
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	velocity = velocity.move_toward(new_velocity,0.25)
	target_position()
	move_and_slide()
	
func target_position():
	navigation_agent_3d.target_position = player.position
