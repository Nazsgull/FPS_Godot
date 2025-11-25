extends CharacterBody3D
class_name Player

#Inventory
@export var inv: Inventory

#Movement & constants
var current_speed = 5.0
const JUMP_VELOCITY = 4.5
@export var WALKING_SPEED = 5.0
@export var SPRINTING_SPEED = 8.0
@export var CROUCHING_SPEED = 2.0
@export var FISHING_SPEED = 0.5
@export var ground_lerp_speed = 10.0
@export var air_lerp_speed = 10.0

#Mouse
@export var mouse_sens = 0.2
@export var invert_y_look = -1
@export var capture_mouse = true


#Head turn
@onready var head = $head
@onready var head_height = 1.8
var direction = Vector3.ZERO

#Crouching
var uncrouched_height = 1.8
var crouching_depth = -0.65

@onready var standing_collision_shape = $standing_collision_shape
@onready var crouching_collision_shape = $crouching_collision_shape
@onready var ray_cast_3d = $uncrouching_raycast

#Pause
var paused = false
@onready var pause_menu = $head/Camera3D/PauseMenu
@onready var pointer = $pointer

@onready var equippables_bar = $head/Camera3D/equippables_bar
@onready var fishingmode_anim_player = $fishingmode_animPlayer
var isFishing = false
enum player_mov_states {
	CROUCHING,
	WALKING,
	SPRINTING,
	JUMPING,
	FISHING
	}
#We start walking by default
var current_mov_state : player_mov_states = player_mov_states.WALKING
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var fishcount_updater = $fishcount_updater

var is_fishing = false

func _ready():
	Messenger.player = self
	if capture_mouse:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	fishcount_updater.start()

func handle_pickup(scene_path:String, tipo:Messenger.ToolTypes):
	equippables_bar.add_tool(scene_path,tipo)
	

func _input(event):
	if event is InputEventMouseMotion and !paused:
		_rotate_head(event)
		_rotate_fishcount_display(event)
		
func _rotate_head(event: InputEventMouseMotion)->void:
	rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
	head.rotate_x(deg_to_rad(event.relative.y * mouse_sens * invert_y_look))
	head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _rotate_fishcount_display(event: InputEventMouseMotion)->void:
	rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
	fishcount_display.rotate_x(deg_to_rad(event.relative.y * mouse_sens * invert_y_look))
	fishcount_display.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))


func set_state(new_state : player_mov_states) -> void:
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
	elif isFishing:
		current_mov_state = player_mov_states.FISHING
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
		player_mov_states.FISHING:
			handle_fishing(delta)

# Function to handle standing state
func handle_walking(delta) -> void:
	if not ray_cast_3d.is_colliding():
		current_speed = WALKING_SPEED
		standing_collision_shape.disabled = false
		crouching_collision_shape.disabled = true
		head.position.y = lerp(head.position.y, uncrouched_height, delta * ground_lerp_speed)
	else:
		current_mov_state = player_mov_states.CROUCHING


# Function to handle crouching state
func handle_crouching(delta) -> void:
	if(is_on_floor()):
		current_speed = CROUCHING_SPEED
	standing_collision_shape.disabled = true
	crouching_collision_shape.disabled = false
	head.position.y = lerp(head.position.y, uncrouched_height + crouching_depth, delta * ground_lerp_speed)


# Function to handle sprinting state
func handle_sprinting(_delta) -> void:
	current_speed = SPRINTING_SPEED

# Function to handle jumping state
func handle_jumping(_delta) -> void:
	velocity.y = JUMP_VELOCITY
	
func handle_fishing(_delta) -> void:
	current_speed = FISHING_SPEED
	fishingmode_anim_player.play("fishingmode_inout")
	
# Function to handle pausing the game (NOT a movement state)
func handle_pause():
	paused = !paused
	if paused:
		pause_menu.show()
		Engine.time_scale = 0
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pointer.hide()
		Messenger.emit_signal("PAUSED")
	else:
		pause_menu.hide()
		Engine.time_scale = 1
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pointer.show()
		Messenger.emit_signal("UNPAUSED")

	# Get the input direction and handle the movement/deceleration.
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
	if Input.is_action_just_pressed("Pause"):
		handle_pause()

	#Handle movement states, if not fishing
	if !is_fishing:
		_update_state_machine(delta)
	
	#Gravity!
	if not is_on_floor():
		velocity.y -= gravity * delta
	get_input(delta)

#FISH AREA
@export var fishcount: int = 0
@onready var fishcount_display = $fishcount_display
@onready var bank = Messenger.fish_bank

func get_fish():
	return fishcount

func set_fish(new_fish: int)-> void:
	fishcount = new_fish
	_update_fishcount_display()

func _update_fishcount_display():
	fishcount_display.text = (str(fishcount)+" fish") 

func _on_timer_timeout():
	_update_fishcount_display()
	
func _handle_interacted():
	self.queue_free()
