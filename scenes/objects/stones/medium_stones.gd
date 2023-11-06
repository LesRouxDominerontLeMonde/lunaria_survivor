extends Area2D

@onready var collision_shape_2d = $CollisionShape2D


func tween_collect_movement(percent: float, start_position: Vector2):
	global_position = start_position.lerp(Globals.player_pos, percent)


func collected():
	Globals.emit_experience_colected(0)
	queue_free()


func disable_collision():
	collision_shape_2d.disabled = true


#Signal conected _on_area_entered (medium_stone is type area 2D)
func _on_area_entered(_other_area):
	Callable(disable_collision).call_deferred()
	
	var tween_movement = create_tween()
	var tween_size = create_tween()
		
	# stone move back than to the player
	tween_movement.tween_method(tween_collect_movement.bind(global_position), 0.0, 1.0, 0.8)\
	.set_ease(Tween.EASE_IN)\
	.set_trans(Tween.TRANS_BACK)
	# stone upscale a litle than descale back
	tween_size.tween_property($stone_sprite, "scale", Vector2(0.15, 0.15) , 0.4)
	tween_size.tween_property($stone_sprite, "scale", Vector2(0.08, 0.08) , 0.2)
	print($stone_sprite.scale)
	

	
	tween_movement.tween_callback(collected)
