extends Node2D


@export var lightning_scene: PackedScene
@export var wave_size: int = 2

func _on_timer_timeout():
	var total_width = 3200 
	var num_slots = 20  
	var slot_width = total_width / num_slots
	
	var slots = range(num_slots)
	slots.shuffle()
	
	for i in range(wave_size):
		var lightning = lightning_scene.instantiate()
		var slot_index = slots[i]
		
		var x_pos = (slot_index * slot_width) - 400 
		var y_pos = -1000 
		
		lightning.position = Vector2(x_pos, y_pos)
		
		add_child(lightning)
