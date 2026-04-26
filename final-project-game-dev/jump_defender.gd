extends CharacterBody2D

signal hit_player
var starting_position : Vector2
var is_tackling = false

func _ready():
	starting_position = global_position
	$AnimatedSprite2D.play("Idle")
	jump_loop()

func jump_loop():
	while true:
		await get_tree().create_timer(2.0).timeout
		if is_on_floor() and not is_tackling:
			jump()

func jump():
	velocity.y = -600

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()

	if is_tackling:
		return 

	# Better logic: Use velocity to determine if we are airborne
	if not is_on_floor() or abs(velocity.y) > 0:
		$AnimatedSprite2D.animation = "Jumping"
	else:
		$AnimatedSprite2D.animation = "Idle"
	
	$AnimatedSprite2D.play()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if is_tackling: 
		return 
	is_tackling = true
	$Hitbox/CollisionShape2D.set_deferred("disabled", true)
	hit_player.emit()
	$AnimatedSprite2D.play("tackling")
	await get_tree().create_timer(0.8).timeout 
	is_tackling = false
	global_position = starting_position
	$Hitbox/CollisionShape2D.set_deferred("disabled", false)
	
