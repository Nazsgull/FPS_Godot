extends Control

@onready var main = $"../../../"

func handle_resume_pressed() -> void:
	main.handle_pause()

func handle_options_pressed() -> void:
	pass

func handle_quit_pressed() -> void:
	get_tree().quit() #Reemplazar por cargar menú principal. Añadir confirmación.
