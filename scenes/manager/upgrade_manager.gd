extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}

func _ready():
	experience_manager.level_up.connect(on_level_up)


func on_level_up(current_level: int):
	var choose_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	if choose_upgrade == null:
		return
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades([choose_upgrade] as Array[AbilityUpgrade])


func apply_upgrade(upgrade: AbilityUpgrade):
	# bool to check if the current upgrade is in the dic
	var has_upgrade = current_upgrades.has(upgrade.id)
	if !has_upgrade: # if not, then add in the dic at "id" and put value(ressource) on it
		current_upgrades[upgrade.id] = {
			"resource": upgrade, #Ref to the abilityupgrade ressource choosen in the pool before
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
