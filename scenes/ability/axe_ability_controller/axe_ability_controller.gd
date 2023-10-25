extends Node

@export var axe_ability_scene: PackedScene

var damage = 10
var base_wait_time

func _ready():
	base_wait_time = $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)
#	Globals.ability_upgrade_added.connect(on_ability_upgrade_added)


func on_timer_timeout():
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer") 
	if foreground_layer == null:
		return
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var axe_instance = axe_ability_scene.instantiate() as AxeAbility
	foreground_layer.add_child(axe_instance)
	axe_instance.global_position = player.global_position
	axe_instance.hitbox_component.damage = damage
	
