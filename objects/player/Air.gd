extends State

onready var player = get_parent().get_parent()
onready var ray = get_node("RayCast")

const AIR_ACCELERATION: float = 400.0

func run(delta):
	var input_x: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	player.motion_target.x = input_x * player.MAX_SPEED;
	
	# AIR FRICTION
	var motionDiff: Vector2 = Vector2.ZERO - player.motion
	player.motion += motionDiff.clamped(min(motionDiff.length(), player.AIR_FRICTION * delta))
	
	player.motion.y += player.GRAVITY * delta
	
	var xDiff: float = player.motion_target.x - player.motion.x
	player.motion.x += min(abs(xDiff), AIR_ACCELERATION * delta) * sign(xDiff)
	if player.is_on_floor():
		player.state = player.stateGround
	
	player.motion = player.move_and_slide(player.motion, Vector2.UP)
