extends Node

signal experience_update(current_experience: float, target_experience: float)
signal level_up(new_level: int)

var current_experience = 0
var total_experience = 0
var target_experience = 10
var current_level = 1 


func _ready():
	Globals.experience_colected.connect(on_experience_colected)


func add_experience(experience_add: float):
	total_experience += experience_add
	current_experience = min(current_experience + experience_add, target_experience)
	experience_update.emit(current_experience, target_experience)
	if current_experience == target_experience:
		current_experience = 0
		experience_update.emit(current_experience, target_experience)
		level_up.emit(current_level)

func on_experience_colected(number: float):
	add_experience(number)
