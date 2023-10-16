extends TextureProgressBar


func initialize(current, maximum):
	max_value = maximum
	value = current

func _on_player_experience_gained(growth_data):
	print(growth_data)
	for line in growth_data:
		var target_experience = line[0] #target to growth to..
		var experience_required = line[1]
		max_value = experience_required # set the max xp of the lvl 
		await animate_value(target_experience)
		# reset bar to 0 if it's nearly 1°°% full
		if abs(max_value - value) < 0.01: 
			value = 0
		
func animate_value(target_experience):
	var is_runing = false
	var tween = get_tree().create_tween()
	tween.tween_property($".","value",target_experience,1).set_trans(Tween.TRANS_SINE)
	tween.kill()
	while tween.is_running():
		is_runing = true
	await is_runing

