extends Area2D

const win_ui_scene : PackedScene = preload("res://scenes/win_ui.tscn")


func on_player_entered_win_area(_body : Node2D) -> void:
	($"/root/Level/MainLevel" as GameManager).win_game()
