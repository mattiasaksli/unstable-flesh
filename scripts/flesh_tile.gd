class_name FleshTile

extends StaticBody2D

const SPRITE_REGION_RECTS : Array = [
	Vector2(8, 0),
	Vector2(16, 0),
	Vector2(24, 0),
	Vector2(32, 0),
	Vector2(0, 8),
	Vector2(8, 8),
]

onready var sprite : Sprite = $Sprite as Sprite


func _ready():
	var rng : RandomNumberGenerator = RandomNumberGenerator.new()
	rng.randomize()
	
	sprite.region_rect.position = SPRITE_REGION_RECTS[rng.randi_range(0, 5)]


func activate() -> void:
	set_process(true)
	set_physics_process(true)
	visible = true


func deactivate() -> void:
	set_process(false)
	set_physics_process(false)
	visible = false
