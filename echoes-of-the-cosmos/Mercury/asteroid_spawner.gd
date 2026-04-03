extends Node2D


@export var asteroid_scene: PackedScene
@export var wave_size: int = 6

func _on_timer_timeout():
	var total_width = 3200 # Your specific game width
	var num_slots = 20     # More slots = better spread for a wide screen
	var slot_width = total_width / num_slots
	
	var slots = range(num_slots)
	slots.shuffle()
	
	for i in range(wave_size):
		var asteroid = asteroid_scene.instantiate()
		
		# Pick a unique slot from the shuffled list (no overlap!)
		var slot_index = slots[i]
		# Position it in the center of that slot
		var x_pos = (slot_index * slot_width) + (slot_width / 2)
		var y_pos = -1000 # This puts them 1000 pixels above the top of the screen (0)
		
		# Keep your vertical start height consistent
		asteroid.position = Vector2(x_pos, y_pos)
		
		add_child(asteroid)

		
