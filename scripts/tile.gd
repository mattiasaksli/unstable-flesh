class_name Tile

extends Node

enum {NORMAL, EVIL}

var _state : int = NORMAL


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func change_to_evil() -> void:
	_state = EVIL


func change_to_normal() -> void:
	_state = NORMAL
