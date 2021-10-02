extends State

onready var player = get_parent().get_parent()

const GROUND_ACCELERATION: float = 50.0
const BACKFLIP_FORCE: float = 140.0

func run(delta):
	var input_x: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var input_jump: bool = Input.is_action_just_pressed("ui_up")
	
	player.motion_target.x = 0;
	
	player.update_variable_jumping()
	
	# AIR FRICTION
	var motionDiff: Vector2 = Vector2.ZERO - player.motion
	player.motion += motionDiff.clamped(min(motionDiff.length(), player.AIR_FRICTION * delta))
	
	player.motion.y += player.GRAVITY * delta
	
	var xDiff: float = player.motion_target.x - player.motion.x
	if player.is_on_floor():
		player.motion.x += min(abs(xDiff), GROUND_ACCELERATION * delta) * sign(xDiff)
		if input_jump:
			player.is_jumping = true
			player.motion.y = -BACKFLIP_FORCE
	else:
		player.state = player.stateAir
		pass
	
	player.animations.travel('Turn')
	if (player.motion.x) == 0:
		player.state = player.stateGround
		player.is_facing_right = !player.is_facing_right
	
	player.motion = player.move_and_slide(player.motion, Vector2.UP)
