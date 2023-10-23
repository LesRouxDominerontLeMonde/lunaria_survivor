extends Node

const SPAWN_RADIUS = 330 # display/window/size/viewport_width : 640.. 640/2 +10

@export var slime_scene: PackedScene

func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	# Create Random enemy spawn outside of the visible window
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = Globals.player_pos + (random_direction * SPAWN_RADIUS)
	
	# Instantiate and give the spawn pos
	var enemy = slime_scene.instantiate() as Node2D
	
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
	enemy.global_position = spawn_position
