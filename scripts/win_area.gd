extends Area2D

const win_ui_scene : PackedScene = preload("res://scenes/ui.tscn")


func on_player_entered_win_area(_body : Node2D) -> void:
	get_tree().change_scene_to(win_ui_scene)
