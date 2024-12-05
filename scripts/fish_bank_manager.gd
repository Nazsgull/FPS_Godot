extends Node3D
@onready var fish_label = $Label3D
@onready var player = get_tree().get_first_node_in_group("player")

var fish_actual : int = 3
var fish_upkeep : int = 1

signal in_debt_s
	
var in_debt : bool = fish_actual < 0
var default_label_color : Color = Color.DARK_GRAY
var debt_label_color : Color = Color.CRIMSON

var days : int = 0

func get_fish_upkeep() -> int:
	return fish_upkeep

func _ready():
	_update_text()

func _day_pass()-> void:
	fish_actual = fish_actual - fish_upkeep
	_update_text()
	days += 1

func _update_text()-> void:
	fish_label.text = (str(fish_actual) + "[-" + str(fish_upkeep) + "]")
	if (in_debt):
		fish_label.set("theme_override_colors/font_color",debt_label_color)
		emit_signal("in_debt_s")
	else:
		fish_label.set("theme_override_colors/font_color",default_label_color)


func donate_1fish(a) -> void:
	var player_fish : int = player.get_fish()
	if(player_fish - 1 >= 0):	
		fish_actual += 1
		player.set_fish(player_fish-1)
	
	
func _process(_delta):
	_update_text()

