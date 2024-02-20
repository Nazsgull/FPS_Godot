extends Equippable

func _physics_process(_delta):
	if Input.is_action_just_pressed("main_action"):
		var scene = load("res://scenes/objects/Testing/test_object_A.tscn")
		var scene_instance:Node3D = scene.instantiate()
		get_tree().root.get_child(0).add_child(scene_instance)
		
		scene_instance.global_position = self.position
		
