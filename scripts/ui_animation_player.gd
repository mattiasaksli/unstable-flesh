extends AnimationPlayer


func _ready():
	play("FadeIn")
	yield(self, "animation_finished")
	
	get_tree().change_scene_to(load("res://scenes/title_screen.tscn"))
