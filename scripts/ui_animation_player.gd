extends AnimationPlayer


func _ready():
	play("FadeIn")
	yield(self, "animation_finished")
	yield(get_tree().create_timer(3), "timeout")
	get_tree().quit()
