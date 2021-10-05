extends State

onready var player = get_parent().get_parent()
onready var jumpSound : AudioStreamPlayer = $"../../JumpSound" as AudioStreamPlayer

const GROUND_ACCELERATION: float = 200.0
const JUMP_FORCE: float = 110.0

var movement_time: float = 0.0

func run(delta):
	var input_x: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var input_jump: bool = Input.is_action_just_pressed("ui_up")
	
	if input_jump:
		_play_jump_sound()
	
	if input_x != 0:
		movement_time += delta * 10
	else: 
		movement_time *= 0.8
	
	
	player.motion_target.x = input_x * player.MAX_SPEED;
	
	player.update_variable_jumping()
	
	# AIR FRICTION
	var motionDiff: Vector2 = Vector2.ZERO - player.motion
	player.motion += motionDiff.clamped(min(motionDiff.length(), player.AIR_FRICTION * delta))
	
	player.motion.y += player.GRAVITY * delta
	
	var xDiff: float = player.motion_target.x - player.motion.x
	if player.is_on_floor():
		player.motion.x += min(abs(xDiff), GROUND_ACCELERATION * delta) * sign(xDiff)
		if input_jump or player.is_jump_queued > 0.0:
			player.is_jump_queued = 0.0
			player.is_jumping = true
			player.motion.y = -JUMP_FORCE
	else:
		player.state = player.stateAir
		pass
	
	player.animations.travel('Idle' if player.motion.x == 0 else 'Run')
	player.is_facing_right = player.is_facing_right if input_x == 0 else (input_x > 0)
	if abs(player.motion.x) * 1.8 > player.MAX_SPEED && sign(player.motion.x) != sign(player.motion_target.x) && movement_time > 1.5 && input_x != 0:
		movement_time = 0
		player.state = player.stateTurn
		player.is_facing_right = player.motion.x > 0
	
	player.motion = player.move_and_slide(player.motion, Vector2.UP)


func _play_jump_sound() -> void:
	if jumpSound.playing:
		return
	jumpSound.stream = preload("res://sounds/t88deldud/jump2.wav")
	jumpSound.play()
