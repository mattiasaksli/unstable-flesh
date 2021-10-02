extends State

onready var player = get_parent().get_parent()

const GROUND_ACCELERATION: float = 600.0
const JUMP_FORCE: float = 110.0

func run(delta):
	var input_x: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var input_jump: bool = Input.is_action_just_pressed("ui_up")
	
	player.motion_target.x = input_x * player.MAX_SPEED;
	
	player.animations.travel('Idle' if input_x == 0 else 'Run')
	
	# AIR FRICTION
	var motionDiff: Vector2 = Vector2.ZERO - player.motion
	player.motion += motionDiff.clamped(min(motionDiff.length(), player.AIR_FRICTION * delta))
	
	player.motion.y += player.GRAVITY * delta
	
	var xDiff: float = player.motion_target.x - player.motion.x
	if player.is_on_floor():
		player.is_facing_right = player.is_facing_right if input_x == 0 else (input_x > 0)
		player.motion.x += min(abs(xDiff), GROUND_ACCELERATION * delta) * sign(xDiff)
		if input_jump:
			player.motion.y = -JUMP_FORCE
	else:
		player.state = player.stateAir
	
	player.motion = player.move_and_slide(player.motion, Vector2.UP)
