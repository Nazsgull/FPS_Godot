extends Equippable


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(_delta):
	if Input.is_action_just_pressed("main_action"):
		var scene = load("res://scenes/objects/Testing/test_object_A.tscn")
		var scene_instance:Node3D = scene.instantiate()
		get_tree().root.get_child(0).add_child(scene_instance)
		

		
