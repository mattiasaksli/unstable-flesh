extends State

onready var player = get_parent().get_parent()

const JUMP_FORCE: float = 90.0

func run(delta):
	var input_y: int = int(Input.is_action_just_pressed("ui_up")) - int(Input.is_action_just_pressed("ui_down"))
	
	player.motion.y = 0;
	
	player.animations.travel('Ledge')
	
	if input_y == 1:
		player.motion.y = -JUMP_FORCE
		player.state = player.stateAir
	elif input_y == -1:
		player.state = player.stateAir
		
	player.motion = player.move_and_slide(player.motion, Vector2.UP)
