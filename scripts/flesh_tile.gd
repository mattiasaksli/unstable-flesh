class_name FleshTile

extends StaticBody2D

export var spikeScene : PackedScene

onready var sprite : Sprite = $Sprite as Sprite
onready var rays: Array = get_node("Rays").get_children()
onready var tilemap: TileMap = get_node("../Tilemap")

var rng: RandomNumberGenerator
var is_active: bool = false
var target_opacity: float = 0
var free_spaces: Array = []
var hazards: Array = []
var has_checked_spaces: bool = false

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	randomize_sprite()
	sprite.modulate.a = 0

func _check_open_spaces():
	free_spaces = []
	
	if (tilemap):
		var rect: Rect2 = tilemap.get_used_rect()
		if position <= rect.position * 8 or position + Vector2(8,8) > rect.end * 8:
			$Rays.queue_free()
			return
	
	for item in rays:
		var raycast: RayCast2D = item
		
		if !raycast.is_colliding():
			free_spaces.append(raycast.cast_to.normalized())
	$Rays.queue_free()

func _place_spikes():
	for space in free_spaces:
		var spike = spikeScene.instance()
		
		spike.hidden_position = Vector2(4.0, 4.0)
		spike.set_orientation(space)
		spike.is_active = false
		
		add_child(spike)
		hazards.append(spike)

func randomize_sprite():
	sprite.frame = rng.randi_range(1, 5)
	
func _process(delta):
	if !has_checked_spaces:
		has_checked_spaces = true
		_check_open_spaces()
		_place_spikes()

	target_opacity = 1.0 if is_active else 0.0
	sprite.modulate.a += (target_opacity - sprite.modulate.a) * .09
	if is_active:
		pass
	else:
		if sprite.modulate.a < 0.01:
			sprite.modulate.a = 0
			set_process(false)

func activate() -> void:
	if !is_active:
		randomize_sprite()
		set_process(true)
		is_active = true
		for hazard in hazards:
			if rng.randi_range(1, 3) != 1:
				hazard.is_active = true
				hazard.counter = hazard.READY_WAIT_TIME

func deactivate() -> void:
	is_active = false
	for hazard in hazards:
		hazard.is_active = false
