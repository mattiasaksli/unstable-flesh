class_name GameManager

extends Node2D

const lose_scene : PackedScene = preload("res://scenes/lose_ui.tscn")
const win_scene : PackedScene = preload("res://scenes/win_ui.tscn")

var _keys_collected : int = 0

onready var door1 : Door = $Door1 as Door
onready var door2 : Door = $Door2 as Door
onready var door3 : Door = $Door3 as Door


func add_key() -> void:
	_keys_collected += 1
	
	match _keys_collected:
		1:
			door1.open_door()
		2:
			door2.open_door()
		3:
			door3.open_door()
		_:
			printerr("No more doors to open")


func game_over() -> void:
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene_to(lose_scene)


func win_game() -> void:
	get_tree().change_scene_to(win_scene)
