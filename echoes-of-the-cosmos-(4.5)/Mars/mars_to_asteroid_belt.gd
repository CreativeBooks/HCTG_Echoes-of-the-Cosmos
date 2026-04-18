extends Node2D



func _on_asteroid_belt_pressed() -> void:
	get_tree().change_scene_to_file("res://Asteroid Belt/asteroid_belt.tscn")
