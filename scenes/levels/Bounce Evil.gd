extends Node2D

const SPEED: float = 20.0

var bounds: Rect2
var direction: Vector2

func _ready():
	bounds = get_node("../Tilemap").get_used_rect()
	bounds.position *= 8.0
	bounds.end = bounds.position + bounds.size * 8.0
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var angle: float = rng.randi_range(0, 3) * 90.0 + 45.0
	direction = Vector2(sin(deg2rad(angle)), cos(deg2rad(angle))) * SPEED
	
func _physics_process(delta):
	position += direction * delta

	if (position.x < bounds.position.x or position.x > bounds.end.x):
		direction.x *= -1

	if (position.y < bounds.position.y or position.y > bounds.end.y):
		direction.y *= -1
