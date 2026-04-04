extends Area2D

var speed: float
var slant: float = -500

func _ready():
	speed = randf_range(800.0, 1000.0)

func _physics_process(delta):
	position.y += speed * delta
	position.x += slant * delta 

	
	if position.y > 1100: 
		queue_free()

func _on_body_entered(body):
	if body.name == "Character":
		get_tree().reload_current_scene()
