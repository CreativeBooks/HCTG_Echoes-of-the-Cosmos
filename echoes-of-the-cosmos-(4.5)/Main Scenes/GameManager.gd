extends Node


var respawn_count = 0
const Max_respawn = 10

func AddRespawn():
	respawn_count += 1
	print("Deaths: ", respawn_count)
	if respawn_count >= Max_respawn:
		respawn_count = 0
		get_tree().change_scene_to_file("res://Main Scenes/GameOver.tscn")
	else:
		get_tree().call_deferred("reload_current_scene")
