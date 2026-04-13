extends Node2D

@export var disk_scene: PackedScene 
@onready var timer = $Timer

var min_y = 100 
var max_y = 800 

func _ready():
	spawn_disk()

func spawn_disk():
	if disk_scene:
		var disk = disk_scene.instantiate()
		
		get_tree().current_scene.add_child(disk)
		
		var random_y = randf_range(min_y, max_y)
		
		disk.global_position = Vector2(3000, random_y)
		
		disk.z_index = 50
		
		timer.wait_time = randf_range(0.5, 1.5)
		timer.start()

func _on_timer_timeout():
	spawn_disk()
