extends CanvasLayer

@export var arena_time_manager: Node
@onready var label_time = $MarginContainer/LabelTime

func _process(delta):
	if arena_time_manager == null:
		return
	var time_elapsed = arena_time_manager.get_time_elapsed()
	label_time.text = format_seconds_to_string(time_elapsed)
	
func format_seconds_to_string(seconds: float):
	# Change the time format to more readeable
	var minutes = floor(seconds / 60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(minutes) + ":" + ("%02d" % floor(remaining_seconds))
	
