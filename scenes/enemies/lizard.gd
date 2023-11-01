extends CharacterBody2D

@onready var velocity_component = $VelocityComponent


func _process(_delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	
	if Globals.player_pos.x - global_position.x <= 0:
		$AnimatedSprite2D.scale = Vector2(-1, 1)
	else:
		$AnimatedSprite2D.scale = Vector2.ONE
