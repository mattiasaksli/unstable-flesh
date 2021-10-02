extends KinematicBody2D

const State = preload("res://scripts/State.gd")

onready var stateGround: State = get_node("States/Ground");
onready var stateAir: State = get_node("States/Air");
onready var stateLedge: State = get_node("States/Ledge");
onready var stateTurn: State = get_node("States/Turn");

const MAX_SPEED: float = 48.0
const GRAVITY: float = 300.0

const AIR_FRICTION: float = 80.0

var motion: Vector2 = Vector2.ZERO
var motion_target: Vector2 = Vector2.ZERO

var state: State = null

var is_facing_right: bool = true
var is_jumping: bool = false
var is_jump_queued: float = 0.0;
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
	
func update_variable_jumping():
	is_jumping = false if motion.y > 0 else is_jumping
	if (not Input.is_action_pressed("ui_up")) and is_jumping:
		is_jumping = false
		return true;
	return false;
