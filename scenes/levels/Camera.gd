extends Node2D

onready var player = get_node("../Player")
onready var tilemap: TileMap = get_node("../Tilemap")
onready var camera: Camera2D = get_node("Camera2D")

func _ready():
	var bounds: Rect2 = tilemap.get_used_rect()
	
	bounds.position *= 8
	bounds.size *= 8
	
	var leftLimit: float = bounds.position.x
	var rightLimit: float = bounds.position.x + bounds.size.x
	var topLimit: float = bounds.position.y
	var bottomLimit: float = bounds.position.y + bounds.size.y
	
	camera.limit_left = leftLimit
	camera.limit_right = rightLimit
	camera.limit_top = topLimit
	camera.limit_bottom = bottomLimit

func _process(delta):
	position.x = player.position.x
	position.y = player.position.y


func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
