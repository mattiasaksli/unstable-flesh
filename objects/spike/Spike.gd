extends Area2D

const READY_WAIT_TIME: float = 4.0
const PRIME_TIME: float = 5.0
const EXTENDED_TIME: float = 5.0

onready var player = $"/root/Level/MainLevel/Player"
onready var sprite = $Sprite
onready var collider: CollisionShape2D = $Collider
onready var ray: RayCast2D = $Ray

onready var soundPlayer : AudioStreamPlayer = $AudioPlayer as AudioStreamPlayer
onready var primeSound = preload("res://sounds/t88deldud/spike_prime.wav")
onready var extendSound = preload("res://sounds/t88deldud/spike_extend.wav")

var target_position: Vector2
var hidden_position: Vector2
var is_active: bool
var orientation: Vector2

var is_primed: bool = false
var is_extended: bool = false
var counter: float = 0
onready var animations = $Animation.get("parameters/playback")
var is_player: bool = false

func _ready():
	hidden_position = position
	orientation = Vector2.UP
	is_active = false
	set_physics_process(false)
	
func set_orientation(orient: Vector2):
	orientation = orient
	rotation_degrees = rad2deg(-orient.angle_to(Vector2.UP))
	position = hidden_position + orientation * 8.0
	
func _process(delta):
	var speed: float = .1
	if is_active:
		speed = .1
		target_position = Vector2.ZERO
		counter -= delta * 10.0
		if ray.is_colliding() && !is_primed && player.state != player.stateDeath && counter < 0.0:
			is_primed = true
			counter = PRIME_TIME
			soundPlayer.stream = primeSound
			soundPlayer.play()
		if is_primed && !is_extended:
			speed = .01
			target_position = Vector2.DOWN * 8.0
			if counter < 0:
				is_extended = true
				counter = EXTENDED_TIME
				animations.travel('Extend')
				soundPlayer.stream = extendSound
				soundPlayer.play()
		if is_extended:
			speed = .12
			target_position = Vector2.DOWN
			if is_player:
				_player_died()
			if counter < 0:
				is_primed = false
				is_extended = false
				counter = 0
				animations.travel('Idle')
	else:
		animations.travel('Idle')
		is_primed = false
		is_extended = false
		counter = 0
		speed = .01
		target_position = Vector2.DOWN * 8.0
	sprite.position += (target_position - sprite.position) * speed * delta * 80.0


func _player_died():
	if player.state != player.stateDeath:
		player.state = player.stateDeath
		player.motion = orientation * 60.0
		($"/root/Level/MainLevel" as GameManager).game_over()


func _on_Spike_body_entered(_body):
	is_player = true


func _on_Spike_body_exited(_body):
	is_player = false
