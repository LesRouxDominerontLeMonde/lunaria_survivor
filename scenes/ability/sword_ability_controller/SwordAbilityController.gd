extends Node

@export var sword_ability: PackedScene
var damage = 5

func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	# Maybe change to Globals.player ?
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var sword_instance = sword_ability.instantiate() as SwordAbility
	player.get_parent().add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage
	sword_instance.global_position = Globals.player_pos

	
