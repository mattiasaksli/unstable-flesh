extends AnimationPlayer


func _ready():
	self.play("FadeIn")
	yield(self, "animation_finished")
	
	_load_title_screen()


func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	elif event.is_action_pressed("ui_accept"):
		self.seek(self.current_animation_length)
		_load_title_screen()


func _load_title_screen() -> void:
	get_tree().change_scene_to(load("res://scenes/title_screen.tscn"))
