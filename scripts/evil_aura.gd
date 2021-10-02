extends StaticBody2D



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_tile_entered_aura(tile : Tile) -> void:
	tile.change_to_evil()


func _on_tile_exited_aura(tile : Tile) -> void:
	tile.change_to_normal()
