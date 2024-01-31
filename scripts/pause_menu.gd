extends Control

@onready var player_root = $"../../../" #we jump 3 up in the player component hierarchy
@onready var main_menu_path = "res://scenes/UI/main_menu.tscn"
func handle_resume_pressed() -> void:
	player_root.handle_pause()

func handle_options_pressed() -> void:
	pass

func handle_quit_pressed() -> void:
	player_root.handle_pause()
	get_tree().change_scene_to_file(main_menu_path)
