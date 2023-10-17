extends Area2D


func _on_area_entered(area):
	# add the stone via the function add_stone on the player, AND destroy the stone after
	Globals.emit_experience_colected(10)
	queue_free()
