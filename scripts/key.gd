extends Area2D

var _game_manager : GameManager


func _enter_tree():
	_game_manager = $"/root/MainLevel" as GameManager


func _on_player_entered(body: Node2D) -> void:
	_game_manager.add_key()
	
	self.queue_free()
