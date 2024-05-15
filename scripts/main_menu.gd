extends Control

var game_start = "res://scenes/maps/test_area.tscn"
@onready var panel = $Panel

@onready var credits = $Credits

func _init():
	Engine.time_scale = 1
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#Triggered when "BT_Play" is pressed
#Loads your first level, in this case "test_area.tscn"
func _on_bt_play_pressed():
	get_tree().change_scene_to_file(game_start)
#Triggered when "BT_Options" is pressed
func _on_bt_options_pressed():
	pass # Replace with function body.

#Triggered when "BT_Credits" is pressed
func _on_bt_credits_pressed():
	panel.hide()
	credits.show()
	credits.main_menu = panel
#Triggered when "BT_Quit" is pressed
func _on_bt_quit_pressed():
	get_tree().quit()
