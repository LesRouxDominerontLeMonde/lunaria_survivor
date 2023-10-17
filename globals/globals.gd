extends Node

signal experience_colected(number: float)

var player_pos: Vector2

func emit_experience_colected(number: float):
	experience_colected.emit(number)
