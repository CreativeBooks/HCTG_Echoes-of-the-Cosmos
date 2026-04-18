extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var jump_count = 0
var just_respawned := false
const FALL_LIMIT_Y = 959
var respawn_position: Vector2
var can_fall := true
var shield_count = 2
var is_shielded = false
@export var belt_gravity_strength := 800.0
var current_belt_asteroid: Node2D = null

@onready var Shield_Counter = get_node("/root/Mercury1/CanvasLayer/Shield_Counter")
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	find_respawn_point()
	update_shield_ui()

func _physics_process(delta: float) -> void:
	
	update_belt_navigation()
	
	if current_belt_asteroid:
		var dir_to_center = (current_belt_asteroid.global_position - global_position).normalized()
		velocity += dir_to_center * belt_gravity_strength * delta
		up_direction = -dir_to_center
		rotation = lerp_angle(rotation, dir_to_center.angle() + PI/2, 0.1)
		
		if is_on_floor():
			jump_count = 0
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jump_count = 0
	rotation = lerp_angle(rotation, 0, 0.1) 
	up_direction = Vector2.UP

	if Input.is_action_just_pressed("Jump") and jump_count < 2:
		jump_count += 1
		if current_belt_asteroid:
			velocity = up_direction * 500
		else:
			velocity.y = JUMP_VELOCITY
	

	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if current_belt_asteroid:
			var move_dir = up_direction.orthogonal()
			velocity = velocity.move_toward(move_dir * -direction * SPEED, SPEED)
		else:
			velocity.x = direction * SPEED 
	else:
		# Existing friction logic 
		var f_speed = SPEED if is_on_floor() else SPEED * delta
		velocity.x = move_toward(velocity.x, 0, f_speed)
	
	if can_fall and position.y > FALL_LIMIT_Y:
		print("Player fell off the level (Y = ", position.y, ")")
		respawn()
	
	if just_respawned and is_on_floor():
		can_fall = true
		just_respawned = false
		
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		elif direction < 0:
				animated_sprite.play("Backwards")
		else:
			animated_sprite.play("Walk")

	move_and_slide()
	
func update_belt_navigation():
	var belt_rocks = get_tree().get_nodes_in_group("belt_gravity")
	var nearest_dist = INF
	current_belt_asteroid = null # Reset so it doesn't stick to rocks from other scenes
	
	for r in belt_rocks:
		var dist = global_position.distance_to(r.global_position)
		if dist < nearest_dist and dist < 1000:
			nearest_dist = dist
			current_belt_asteroid = r

func _input(event):
	if event.is_action_pressed("Shield"):
		if shield_count > 0 and not is_shielded:
			activate_shield()

func activate_shield():
	is_shielded = true
	shield_count -= 1
	update_shield_ui()
	
	modulate = Color(0.577, 0.754, 1.0, 0.588)
	
	print("Shield Activate")
	await get_tree().create_timer(2.0).timeout
	
	
	
	deactivate_shield()

func deactivate_shield():
	is_shielded = false
	modulate = Color(1, 1, 1, 1)  
	print("Shield Deactivate")

func update_shield_ui():
	if Shield_Counter:
		Shield_Counter.text = "Shield Counter: " + str(shield_count)

func find_respawn_point():
	var root = get_tree().current_scene
	var point = root.get_node_or_null("RespawnPoint")
	
	if point:
		respawn_position = point.global_position
		print("RespawnPoint found at: ", respawn_position)
	else:
		respawn_position = global_position
		print("RespawnPoint not found! Defaulting to current position")

func respawn():
	print("Respawning player...")
	position = respawn_position  # Use position, not global_position
	velocity = Vector2.ZERO
	can_fall = false
	just_respawned = true
	print(" Player moved to: ", position)
	get_tree().reload_current_scene()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()
		

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_area_2d_3_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://Mercury/mercury_2.tscn")


func _on_lava_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()
		


func _on_next_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://Mercury/venus_to_mercury.tscn")


func _on_rebound_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_respawning_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_rebound_1_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()

func _on_respawning_2_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_top_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_to_venus_2_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://Venus/venus_2.tscn")


func _on_respawn_3_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_off_screen_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_to_mars_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://Venus/venus_to_mars.tscn")


func _on_repsawn_4_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_rebound_2_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_sulfur_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_rebound_5_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()

func _on_to_asteroid_belt_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://Mars/mars_to_Asteroid_belt.tscn")


func _on_repsawn_5_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_to_jupiter_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://Asteroid Belt/belt_to_Jupiter.tscn")


func _on_respawn_6_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_to_saturn_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://Jupiter/jupiter_2.tscn")


func _on_respawn_7_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_to_saturn_2_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://Jupiter/jupiter_to_saturn.tscn")


func _on_respawn_8_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_to_saturn_3_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://Saturn/saturn_2.tscn")


func _on_respawn_9_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_respawn_10_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_to_uranus_2_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://Uranus/uranus_2.tscn")


func _on_respawn_11_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_to_neptune_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://Uranus/uranus_to_neptune.tscn")


func _on_respawn_12_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()

func _on_to_neptune_2_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://Neptune/neptune_2.tscn")


func _on_to_uranus_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://Saturn/saturn_to_uranus.tscn")


func _on_respawn_13_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().reload_current_scene()


func _on_game_over_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://Main Scenes/GameOver.tscn")
