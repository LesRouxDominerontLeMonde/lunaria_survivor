extends Node

var current_experience = 0
var total_experience = 0

func _ready():
	Globals.experience_colected.connect(on_experience_colected)


func add_experience(experience: float):
	current_experience += experience
	total_experience += experience
	print(current_experience)
	

func on_experience_colected(number: float):
	add_experience(number)
	
