extends Control


const main_level : PackedScene = preload("res://scenes/levels/main_level.tscn")

onready var animation_player : AnimationPlayer = $AnimationPlayer as AnimationPlayer


func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	elif event.is_action_pressed("ui_accept"):
		
		animation_player.play("FadeOut")
		
		yield(animation_player, "animation_finished")
		
		get_tree().change_scene_to(main_level)
