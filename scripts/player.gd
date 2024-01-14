extends CharacterBody3D

#Movement & constants
var current_speed = 5.0
const JUMP_VELOCITY = 4.5
@export var WALKING_SPEED = 5.0
@export var SPRINTING_SPEED = 8.0
@export var CROUCHING_SPEED = 2.0
@export var ground_lerp_speed = 10.0
@export var air_lerp_speed = 10.0

#Mouse
@export var mouse_sens = 0.3
@export var invert_y_look = -1
@export var capture_mouse = false

#Head turn
@onready var head = $head
@onready var head_height = 1.8
var direction = Vector3.ZERO

#Crouching
var uncrouched_height = 1.8
var crouching_depth = -1.1

@onready var standing_collision_shape = $standing_collision_shape
@onready var crouching_collision_shape = $crouching_collision_shape
@onready var ray_cast_3d = $RayCast3D

enum player_mov_states {
	CROUCHING,
	WALKING,
	SPRINTING,
	JUMPING
	}
#We start walking by default
var current_mov_state : player_mov_states = player_mov_states.WALKING
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	if capture_mouse:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(event.relative.y * mouse_sens * invert_y_look))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _set_state(new_state : player_mov_states) -> void:
	current_mov_state = new_state
	
func _update_state_machine(delta) -> void:
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		current_mov_state = player_mov_states.JUMPING
	elif Input.is_action_pressed("sprint") and is_on_floor() and !current_mov_state == player_mov_states.CROUCHING:
		current_mov_state = player_mov_states.SPRINTING
	elif Input.is_action_pressed("crouch"):
		current_mov_state = player_mov_states.CROUCHING
	elif !Input.is_action_pressed("sprint"):
		current_mov_state = player_mov_states.WALKING
	else:
		current_mov_state = player_mov_states.SPRINTING


	# Handle movement based on the current state
	match current_mov_state:
		player_mov_states.CROUCHING:
			handle_crouching(delta)
		player_mov_states.WALKING:
			handle_walking(delta)
		player_mov_states.SPRINTING:
			handle_sprinting(delta)
		player_mov_states.JUMPING:
			handle_jumping(delta)

# Function to handle standing state
func handle_walking(delta) -> void:
	if not ray_cast_3d.is_colliding():
		print("walking")
		current_speed = WALKING_SPEED
		standing_collision_shape.disabled = false
		crouching_collision_shape.disabled = true
		head.position.y = lerp(head.position.y, uncrouched_height, delta * ground_lerp_speed)
	else:
		current_mov_state = player_mov_states.CROUCHING


# Function to handle crouching state
func handle_crouching(delta) -> void:
	print("crouching")
	if(is_on_floor()):
		current_speed = CROUCHING_SPEED
	standing_collision_shape.disabled = true
	crouching_collision_shape.disabled = false
	head.position.y = lerp(head.position.y, uncrouched_height + crouching_depth, delta * ground_lerp_speed)


# Function to handle sprinting state
func handle_sprinting(_delta) -> void:
	print("sprinting")
	current_speed = SPRINTING_SPEED

# Function to handle jumping state
func handle_jumping(_delta) -> void:
	print("jumping")
	velocity.y = JUMP_VELOCITY


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
func get_input(delta):
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * current_speed
			velocity.z = direction.z * current_speed
		else:
			velocity.x = lerp(velocity.x,direction.x * current_speed, delta * ground_lerp_speed)
			velocity.z = lerp(velocity.z,direction.z * current_speed, delta * ground_lerp_speed)
	else:
		velocity.x = lerp(velocity.x,direction.x * current_speed, delta * air_lerp_speed)
		velocity.z = lerp(velocity.z,direction.z * current_speed, delta * air_lerp_speed)
	move_and_slide()

func _physics_process(delta):
	print(!current_mov_state == player_mov_states.CROUCHING)
	#Handle movement states
	_update_state_machine(delta)
	
	#Gravity!
	if not is_on_floor():
		velocity.y -= gravity * delta
	get_input(delta)



