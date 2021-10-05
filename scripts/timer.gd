extends Label


var _time_in_seconds : float = 0


func _ready() -> void:
	_time_in_seconds = 0


func _process(delta : float) -> void:
	_time_in_seconds += delta
	
	self.text = get_formatted_time()


func get_formatted_time() -> String:
	if _time_in_seconds > 3600:
		return "Time: 59:59.999"
	
	var milliseconds : float = (_time_in_seconds - (_time_in_seconds as int)) * 1000
	var seconds : float = fmod(_time_in_seconds, 60)
	var minutes : float = fmod(_time_in_seconds, 3600) / 60
	
	return "Time: %02d:%02d.%03d" % [minutes, seconds, milliseconds]
