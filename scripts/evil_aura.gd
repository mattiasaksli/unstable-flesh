extends Area2D

signal activate_flesh_tile(world_pos)
signal deactivate_flesh_tile(world_pos)

onready var flesh_manager : FleshManager = $"/root/MainLevel/Tilemap" as FleshManager


func _ready():
	self.connect("activate_flesh_tile", flesh_manager, "on_activate_flesh_tile")
	self.connect("deactivate_flesh_tile", flesh_manager, "on_deactivate_flesh_tile")


func _on_tile_entered_aura(flesh_tile : Node2D) -> void:
	emit_signal("activate_flesh_tile", flesh_tile.position)


func _on_tile_exited_aura(flesh_tile : Node2D) -> void:
	emit_signal("deactivate_flesh_tile", flesh_tile.position)
