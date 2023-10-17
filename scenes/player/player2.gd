extends CharacterBody2D

signal experience_gained(growth_data)
# CHARACTER STATS
var player_speed = 200
var max_hp: int = 12

# LEVELING SYSTEM
var player_level = 1
var experience = 0
var experience_total = 0
var experience_required = get_required_experience(player_level + 1)

#OTHERS
var stones: int = 0

	
func _process(_delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * player_speed
	move_and_slide()
	Globals.player_pos = global_position
	
func add_stone():
	stones += 1
	print("stone number:", stones)
	gain_experience(50)
	print("experience % =", experience*100/experience_required)
	print("experience_required", experience_required)
	
func get_required_experience(level):
	return round(pow(level, 1.8) + level * 4 + 5)

func gain_experience(amount):
	experience_total += amount
	experience += amount
	var growth_data = [] # var to send value to UI anim bar
	while experience >= experience_required:
		experience -= experience_required
		# stack line in var to Fill the entire xp barin UI
		growth_data.append([experience_required, experience_required])
		level_up()
	# Fill just a portion of the xp bar
	growth_data.append([experience, experience_required])
	emit_signal("experience_gained", growth_data)
	
func level_up():
	player_level += 1
	experience_required = get_required_experience(player_level + 1)
	
