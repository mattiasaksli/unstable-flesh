extends State

onready var player = get_parent().get_parent()
onready var deathSound : AudioStreamPlayer = $"../../JumpSound" as AudioStreamPlayer

const ACCELERATION: float = 200.0

var played_sound: bool = false

func run(delta):
	player.motion_target.x = 0
	
	if !played_sound:
		deathSound.stream = preload("res://sounds/t88deldud/dealth.wav")
		deathSound.play()
		played_sound = true
	
	# AIR FRICTION
	var motionDiff: Vector2 = Vector2.ZERO - player.motion
	player.motion += motionDiff.clamped(min(motionDiff.length(), player.AIR_FRICTION * delta * .2))
	
	player.motion.y += player.GRAVITY * delta
	
	var xDiff: float = player.motion_target.x - player.motion.x
	if player.is_on_floor():
		player.motion.x += min(abs(xDiff), ACCELERATION * delta) * sign(xDiff)
	
	player.animations.travel('Death Ground' if player.is_on_floor() else 'Death Air')
	
	player.motion = player.move_and_slide(player.motion, Vector2.UP)
