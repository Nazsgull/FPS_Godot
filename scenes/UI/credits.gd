extends Control
@onready var scroll_cont = $Panel/ScrollContainer
var is_scroll_enabled = true
var main_menu : Panel

func handle_inputs() -> void:
	if Input.is_action_just_pressed("tool_next") or Input.is_action_just_pressed("tool_prev"):
		is_scroll_enabled = false


func autoscroll():
	scroll_cont.scroll_vertical = scroll_cont.scroll_vertical+1

func handle_back():
	self.hide()
	main_menu.show()

func _process(delta):
	handle_inputs()
	if is_scroll_enabled:
		autoscroll()
	
