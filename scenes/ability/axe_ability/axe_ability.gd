extends Node2D
class_name AxeAbility

const MAX_RADIUS = 200 #How much it go away from the player

@onready var hitbox_component = $HitBoxComponent

var base_rotation = Vector2.RIGHT

func _ready():
	base_rotation = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	var tween = create_tween()
	tween.tween_method(tween_method, 0.0, 2.0, 3) #Varie de 0 a 2 pendant 2 seconde
	tween.tween_callback(queue_free)


func tween_method(rotations: float):
	var percent = rotations / 2
	var curent_radius = percent * MAX_RADIUS
	var current_direction = base_rotation.rotated(rotations * TAU)
	
	var root_position = Vector2.ZERO
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		root_position = global_position #own axe position
	else:
		root_position = player.global_position
	
	global_position = root_position + (current_direction * curent_radius)
	
