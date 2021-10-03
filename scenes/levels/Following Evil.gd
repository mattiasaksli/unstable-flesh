extends Node2D

onready var player = get_node("../Player")

func _process(delta):
	position += (player.position - position) * 0.005
