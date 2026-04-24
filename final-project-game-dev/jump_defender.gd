extends CharacterBody2D

signal hit_player
var starting_position : Vector2
var is_tackling = false

func _ready():
	starting_position = global_position
	$AnimatedSprite2D.animation = "Idle"
	$AnimatedSprite2D.play()
	jump_loop()
func jump_loop():
	while true:
		await get_tree().create_timer(2.0).timeout
		jump()
func jump():
	if is_on_floor() and not is_tackling:
		velocity.y = -600
		$AnimatedSprite2D.animation = "Jumping"
		
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if is_tackling: return 
	is_tackling = true
	$Hitbox/CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite2D.play("tackling")
	hit_player.emit()
	await get_tree().create_timer(1.0).timeout
	$AnimatedSprite2D.play("idle")
	is_tackling = false
	$Hitbox/CollisionShape2D.set_deferred("disabled", false)
	
