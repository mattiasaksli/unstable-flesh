class_name FleshTile

extends StaticBody2D

onready var sprite : Sprite = $Sprite as Sprite

var rng: RandomNumberGenerator
var is_active: bool = false
var target_opacity: float = 0

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	randomize_sprite()
	sprite.modulate.a = 0

func randomize_sprite():
	sprite.frame = rng.randi_range(1, 5)
	
func _physics_process(delta):
	target_opacity = 1.0 if is_active else 0.0
	sprite.modulate.a += (target_opacity - sprite.modulate.a) * .09
	if is_active:
		pass

func activate() -> void:
	randomize_sprite()
	is_active = true

func deactivate() -> void:
	is_active = false
