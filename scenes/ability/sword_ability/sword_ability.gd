extends Node2D
class_name SwordAbility

@onready var hitbox_component: HitBoxComponent = $HitBoxComponent

const offset : Vector2 = Vector2(15,-15)


func _process(_delta):
	position = (Globals.player_pos + offset)
