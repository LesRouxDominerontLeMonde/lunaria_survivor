extends CharacterBody2D

const MAX_SPEED = 75

@onready var health_component: HealthComponent = $HealthComponent


func _process(_delta):
	# var direction = (Globals.player_pos - global_position).normalized()
	# I for some strange godo files bug so i did it in is own func but no reaso to do that ;pS
	var direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_direction_to_player():
	return (Globals.player_pos - position).normalized()
