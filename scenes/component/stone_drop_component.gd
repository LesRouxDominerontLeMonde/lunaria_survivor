extends Node

@export var stone_scene: PackedScene
@export var health_component: Node

func _ready():	
	(health_component as HealthComponent).died.connect(on_died)
	

func on_died():
	if stone_scene == null:
		return
	
	if not owner is Node2D:
		return
	
	var spawn_position = (owner as Node2D).global_position
	var stone_instance = stone_scene.instantiate() as Node2D
	owner.get_parent().add_child(stone_instance)
	stone_instance.global_position = spawn_position
