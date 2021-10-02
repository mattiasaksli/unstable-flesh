extends State

onready var player = get_parent().get_parent()

const ACCELERATION: float = 200.0

func run(delta):
	player.motion_target.x = 0
	
	# AIR FRICTION
	var motionDiff: Vector2 = Vector2.ZERO - player.motion
	player.motion += motionDiff.clamped(min(motionDiff.length(), player.AIR_FRICTION * delta))
	
	player.motion.y += player.GRAVITY * delta
	
	var xDiff: float = player.motion_target.x - player.motion.x
	player.motion.x += min(abs(xDiff), ACCELERATION * delta) * sign(xDiff)
	
	player.animations.travel('Death Ground' if player.is_on_floor() else 'Death Air')
	
	player.motion = player.move_and_slide(player.motion, Vector2.UP)
