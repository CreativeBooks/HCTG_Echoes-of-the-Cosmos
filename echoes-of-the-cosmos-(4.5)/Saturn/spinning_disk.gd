extends Area2D

@export var speed: float = 2000 # Adjust for speed

func _process(delta: float) -> void:
	# Moves the disk strictly horizontal
	# Use += speed for Right, -= speed for Left
	position.x -= speed * delta

func _on_body_entered(body: Node2D) -> void:
	# Check if the object hit is the player by looking for the respawn method
	if body.has_method("respawn"):
		body.respawn() 
		queue_free() # Destroy disk on impact

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # Clean up memory when it leaves the screen [cite: 4]
