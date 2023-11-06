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
	
	var tween = create_tween()
	tween.set_parallel()
		
		# stone movement
	tween.tween_method(tween_collect_movement.bind(global_position), 0.0, 1.0, 0.8)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_BACK)
		# stone upscale and descale back
	tween.tween_property($stone_sprite, "scale", Vector2(0.15, 0.15) , 0.4)
	tween.tween_property($stone_sprite, "scale", Vector2.ZERO , 0.35)\
		.set_delay(0.4)\
		.from(Vector2(0.15, 0.15))\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_CUBIC)
	tween.chain()
	tween.tween_callback(collected)
