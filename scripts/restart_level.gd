extends Node

const level_scene : PackedScene = preload("res://scenes/levels/main_level.tscn")


func _input(event : InputEvent) -> void:
	if event.is_action_pressed("restart"):
		# Remove old node
		var old_scene : Node2D = $"/root/Level/MainLevel" as Node2D
		self.remove_child(old_scene)
		old_scene.call_deferred("free")
		
		# Add newly loaded node
		var next_scene : Node2D = level_scene.instance() as Node2D
		self.add_child(next_scene)
