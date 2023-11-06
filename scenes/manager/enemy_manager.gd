extends Node

const SPAWN_RADIUS = 360 # display/window/size/viewport_width : 640.. 640/2 +10 =330 (I augmented)

@export var slime_scene: PackedScene
@export var lizard_scene: PackedScene
@export var arena_time_manager: Node

var base_spawn_time = 0
var total_enemies = 0
var enemy_table = WeightedTable.new()

func _ready():
	enemy_table.add_item(slime_scene, 10)
	base_spawn_time = $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)
	arena_time_manager.arena_dificulty_increased.connect(on_arena_dificulty_increased)

func on_timer_timeout():
	$Timer.start()
	
	# Create Random enemy spawn outside of the visible window
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = Globals.player_pos + (random_direction * SPAWN_RADIUS)
	
	# Instantiate and give the spawn pos
	var enemy_picked = enemy_table.pick_item()
	print(enemy_picked)
	var enemy = enemy_picked.instantiate() as Node2D
	total_enemies += 1
	print(total_enemies)
	
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
	enemy.global_position = spawn_position


func on_arena_dificulty_increased(arena_dificulty: int):
	# /12 car 60/12 = Every 5 secondes arena dificulty increase
	var time_off = (.1 / 12) * arena_dificulty
	time_off = min(time_off, .7) #Peut-etre changer, 0.7 pour pas descendre en dessous de 0.3s de spawn
	$Timer.wait_time = base_spawn_time - time_off
	
	if arena_dificulty == 2:
		enemy_table.add_item(lizard_scene, 20)
	
