extends CharacterBody2D

@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_component = $HealthComponent
@onready var health_bar = $HealthBar
@onready var abilities = $Abilities

var player_speed = 200
var number_coliding_body = 0

func _ready():
	$HurtArea2D.body_entered.connect(on_body_entered)
	$HurtArea2D.body_exited.connect(on_body_exited)
	# Check in case an enemy is still present after 0.5s timer
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)
	health_component.health_changed.connect(on_health_changed)
	Globals.ability_upgrade_added.connect(on_ability_upgrade_added)
	
	update_health_display()


func _process(_delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * player_speed
	move_and_slide()
	Globals.player_pos = global_position


func check_deal_damage():
	if number_coliding_body == 0 || !damage_interval_timer.is_stopped():
		return
	health_component.damage(10)
	damage_interval_timer.start()
	print(health_component.current_health)


func update_health_display():
	health_bar.value = health_component.get_health_percent()


func on_body_entered(_other_body: Node2D):
	number_coliding_body += 1
	check_deal_damage()


func on_body_exited(_other_body: Node2D):
	number_coliding_body -= 1


func on_damage_interval_timer_timeout():
	check_deal_damage()


func on_health_changed():
	update_health_display()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if not upgrade is Ability: #Si upgrade n'est pas de type Ability: return
		return
	var upgrade_ability = upgrade as Ability
	abilities.add_child(upgrade_ability.ability_controller_scene.instantiate())
