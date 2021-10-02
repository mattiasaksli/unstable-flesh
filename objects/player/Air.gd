extends State

onready var player = get_parent().get_parent()
onready var rayRight: RayCast2D = get_node("RayRight")
onready var rayLeft: RayCast2D = get_node("RayLeft")

const AIR_ACCELERATION: float = 400.0
const GRAB_THRESHOLD: float = 2.0

func run(delta):
	var input_x: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var input_y: int = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
	
	player.motion_target.x = input_x * player.MAX_SPEED;
	
	# AIR FRICTION
	var motionDiff: Vector2 = Vector2.ZERO - player.motion
	player.motion += motionDiff.clamped(min(motionDiff.length(), player.AIR_FRICTION * delta))
	
	player.motion.y += player.GRAVITY * delta
	
	# ANIMATION
	var animation_state = 'Jump Mid'
	if (abs(player.motion.y) > 3):
		animation_state = 'Jump Up' if player.motion.y < 0 else 'Jump Down'
	
	player.animations.travel(animation_state)
	
	var xDiff: float = player.motion_target.x - player.motion.x
	player.motion.x += min(abs(xDiff), AIR_ACCELERATION * delta) * sign(xDiff)
	if player.is_on_floor():
		player.state = player.stateGround
		player.animations.travel('Crouch')
	else:
		var ray: RayCast2D = rayRight if player.motion.x > 0 else rayLeft
		var tilemap: TileMap = ray.get_collider()
		if (tilemap && player.motion.y > 0 && input_x != 0 && input_y != -1):
			var position: Vector2 = ray.get_collision_point()
			var tile_pos: Vector2 = tilemap.world_to_map(position)
			
			if tilemap.get_cell(tile_pos.x - (0 if player.motion.x > 1 else 1), tile_pos.y - 1) == -1:
				var yDiff: float = tile_pos.y * 8 - (player.position.y - 11)
				if (abs(yDiff) < GRAB_THRESHOLD):
					player.is_facing_right = player.motion.x > 0
					player.position.y += yDiff
					player.motion = Vector2.ZERO
					player.state = player.stateLedge
	
	player.motion = player.move_and_slide(player.motion, Vector2.UP)
