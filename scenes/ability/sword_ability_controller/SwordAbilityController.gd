extends Node

@export var sword_ability: PackedScene

var damage = 5
var base_wait_time

func _ready():
	base_wait_time = $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)
	Globals.ability_upgrade_added.connect(on_ability_upgrade_added)


func on_timer_timeout():
	# Maybe change to Globals.player ?
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var sword_instance = sword_ability.instantiate() as SwordAbility
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	if foreground_layer == null:
		return
		
	foreground_layer.add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage
	sword_instance.global_position = Globals.player_pos


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id != "sword_rate":
		pass
	var percent_reduction = current_upgrades["sword_rate"]["quantity"] * 0.1
	$Timer.wait_time = base_wait_time * (1 - percent_reduction)
	$Timer.start()
	
	print($Timer.wait_time)
