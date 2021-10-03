extends Area2D

const PRIME_TIME: float = 4.0
const EXTENDED_TIME: float = 8.0

onready var player = get_tree().root.get_child(0).get_node('Player')
onready var sprite = $Sprite
onready var collider: CollisionShape2D = $Collider
onready var ray: RayCast2D = $Ray

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
		if ray.is_colliding() && !is_primed && player.state != player.stateDeath:
			is_primed = true
			counter = PRIME_TIME
		if is_primed:
			counter -= delta * 10
			speed = .01
			target_position = Vector2.DOWN * 8.0
			if counter < 0:
				is_extended = true
				counter = EXTENDED_TIME
				animations.travel('Extend')
		if is_extended:
			counter -= delta * 10
			speed = .12
			target_position = Vector2.DOWN
			if is_player:
				player.state = player.stateDeath
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
	sprite.position = Vector2.ZERO#+= (target_position - sprite.position) * speed * delta * 50
	
func _on_Spike_body_enter(body): 
	print('entered ', body)


func _on_Spike_body_entered(body):
	is_player = true


func _on_Spike_body_exited(body):
	is_player = false
