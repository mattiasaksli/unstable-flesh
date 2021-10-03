extends AnimationPlayer


func _ready():
	play("FadeIn")
	yield(self, "animation_finished")
	
	get_tree().change_scene_to(load("res://scenes/title_screen.tscn"))


func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
