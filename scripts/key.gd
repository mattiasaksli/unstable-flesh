extends Area2D

const TARGET_MOVE: Vector2 = Vector2(16.0, 56.0)

var _game_manager : GameManager
onready var keySound : AudioStreamPlayer = $KeySound
onready var sprite : Sprite = $Sprite
var is_picked: bool = false
var time: float = 0.0

func _enter_tree():
	_game_manager = $"/root/MainLevel" as GameManager
	
func _process(delta):
	time += delta * 5.0
	sprite.rotation_degrees = cos(time) * 12
	
	if is_picked:
		sprite.modulate.a += (- sprite.modulate.a) * 0.1
		position += (TARGET_MOVE - position).normalized() * 50.0 * delta


func _on_player_entered(body: Node2D) -> void:
	if !is_picked:
		_game_manager.add_key()
		
		keySound.stream = preload("res://sounds/key_pickup.wav")
		keySound.play()
		is_picked = true
