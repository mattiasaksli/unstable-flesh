class_name Door

extends StaticBody2D

onready var _tween : Tween = $Tween as Tween

export var door_open_duration = 1


func open_door() -> void:
	_tween.interpolate_property(
		self,
		"position",
		self.position,
		self.position + Vector2(0, -16),
		door_open_duration, Tween.TRANS_BOUNCE,
		Tween.EASE_OUT
	)
	_tween.start()
