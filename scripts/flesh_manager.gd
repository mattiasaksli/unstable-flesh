class_name FleshManager

extends TileMap

export var flesh_to_world_pos_dict : Dictionary = {}

export var flesh_tile_scene : PackedScene


func _ready() -> void:
	var tiles : Array = get_used_cells()
	
	for tile_pos in tiles:
		_instance_new_flesh_tile(tile_pos)


func _instance_new_flesh_tile(pos : Vector2) -> void:
	var new_flesh_tile : FleshTile = flesh_tile_scene.instance()
	
	new_flesh_tile.position = map_to_world(pos)
	flesh_to_world_pos_dict[pos] = new_flesh_tile
	new_flesh_tile.deactivate()
	
	$"/root/MainLevel".call_deferred("add_child", new_flesh_tile)


func on_activate_flesh_tile(world_pos : Vector2) -> void:
	var flesh_tile : FleshTile = flesh_to_world_pos_dict[world_to_map(world_pos)]
	flesh_tile.activate()


func on_deactivate_flesh_tile(world_pos : Vector2) -> void:
	var flesh_tile : FleshTile = flesh_to_world_pos_dict[world_to_map(world_pos)]
	flesh_tile.deactivate()
