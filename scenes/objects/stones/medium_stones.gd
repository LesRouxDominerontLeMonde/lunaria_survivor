extends Area2D


func _on_body_entered(body):
	# add the stone via the function add_stone on the player, AND destroy the stone after
	body.add_stone()
	queue_free()
