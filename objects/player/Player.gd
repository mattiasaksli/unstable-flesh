extends KinematicBody2D

const State = preload("res://scripts/State.gd")

onready var stateGround: State = get_node("States/Ground");
onready var stateAir: State = get_node("States/Air");
onready var stateLedge: State = get_node("States/Ledge");

const MAX_SPEED: float = 48.0
const GRAVITY: float = 300.0

const AIR_FRICTION: float = 80.0

var motion: Vector2 = Vector2.ZERO
var motion_target: Vector2 = Vector2.ZERO

var state: State = null

var is_facing_right: bool = true
var is_jumping: bool = false
var animations

func _ready():
	state = stateGround
	animations = $Animation.get("parameters/playback")

func _physics_process(delta):
	_animations()
	if state != null:
		state.run(delta)
		
func _animations():
	$Sprite.scale.x = 1 if is_facing_right else -1
	
	pass
