extends Node
class_name HealthComponent

signal died
signal health_changed

@export var max_health: float = 100
var current_health

func _ready():
	current_health = max_health

func damage(damage_amout: float):
	# Security to dont have negative Healt
	current_health = max(current_health - damage_amout, 0)
	health_changed.emit()
	Callable(check_death).call_deferred() # Code to solve error when body is still colinding when Queure_free()


func get_health_percent():
	if current_health <= 0:
		return 0
	return min(current_health / max_health, 1)


func check_death():
	if current_health == 0:
		died.emit()
		owner.queue_free()
		# Owner = the parent 
