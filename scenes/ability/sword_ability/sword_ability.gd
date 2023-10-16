extends Node2D

const offset : Vector2 = Vector2(15,-15)


func _process(_delta):
	position = (Globals.player_pos + offset)
