extends Node2D

var speed: float
var slant: float

func _ready():
	speed = randf_range(800.0, 1000.0)
	slant = randf_range(-500,200)

func _physics_process(delta):
	position.y += speed * delta
	position.x += slant * delta # This adds the diagonal path

	
	if position.y > 1100: 
		queue_free()

func _on_body_entered(body):
	if body.name == "Character":
		get_tree().reload_current_scene()
