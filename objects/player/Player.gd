extends KinematicBody2D

const State = preload("res://scripts/State.gd")

onready var stateGround: State = get_node("States/Ground");
onready var stateAir: State = get_node("States/Air");

const MAX_SPEED: float = 64.0
const GRAVITY: float = 500.0

const AIR_FRICTION: float = 80.0

var motion: Vector2 = Vector2.ZERO
var motion_target: Vector2 = Vector2.ZERO

var state: State = null

func _ready():
	state = stateGround

func _physics_process(delta):
	if state != null:
		state.run(delta)
