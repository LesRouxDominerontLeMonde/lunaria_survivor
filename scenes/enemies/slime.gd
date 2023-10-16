extends CharacterBody2D

const MAX_SPEED = 75


func _ready():
	$Area2D.area_entered.connect(_on_area_2d_area_entered)


func _process(delta):
	# var direction = (Globals.player_pos - global_position).normalized()
	# I for some strange godo files bug so i did it in is own func but no reaso to do that ;pS
	var direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_direction_to_player():
	return (Globals.player_pos - position).normalized()
	

func _on_area_2d_area_entered(other_area: Area2D):
	queue_free()
