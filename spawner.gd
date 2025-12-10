extends Node3D

@onready var timer = $Timer

@onready var marker_3d = $Marker3D

var rand = RandomNumberGenerator.new()

func _init():
	var map = Messenger.map

func randomize_timer():
	timer.wait_time = rand.randi_range(1,5)
	return

func _on_timer_timeout():
	randomize_timer()
	timer.start()

func spawn():
	var random_num = rand.randf_range(0,3)
	if random_num <= 1:
		#A
		pass
	if random_num < 2:
		#B
		pass
	if random_num < 3:
		#C
		pass

