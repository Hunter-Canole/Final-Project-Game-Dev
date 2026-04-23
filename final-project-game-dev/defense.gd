extends CharacterBody2D

signal hit_player
var starting_position : Vector2
var is_tackling = false

func _ready():
	starting_position = global_position
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()
	$Hitbox_Diving/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2Diving.set_deferred("disabled", true)
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if is_tackling: return # If we are already tackling, ignore further hits
	is_tackling = true
	$Hitbox_Normal/CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite2D.play("tackling")
	is_tackling = false
	hit_player.emit()
	await get_tree().create_timer(1.0).timeout
	idle()

func _on_hitbox_diving_body_entered(body: Node2D) -> void:
	if is_tackling: return
	is_tackling = true
	$Hitbox_Diving/CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite2D.play("divetackle")
	hit_player.emit()
	global_position = starting_position
	is_tackling = false
	await get_tree().create_timer(1.0).timeout
	idle()
	
func idle():
	global_position = starting_position
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()
	$Hurtbox/CollisionShape2D.set_deferred("disabled", false)
	$Hitbox_Normal/CollisionShape2D.set_deferred("disabled", false)
	$CollisionShape2D.set_deferred("disabled", false)
	$CollisionShape2Diving.set_deferred("disabled", true)
	$Hitbox_Diving/CollisionShape2D.set_deferred("disabled", true)

func _on_hurtbox_body_entered(body: Node2D) -> void:
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	$Hitbox_Normal/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2Diving.set_deferred("disabled", false)
	$AnimatedSprite2D.animation = "diving"
	$AnimatedSprite2D.play()
	$Hitbox_Diving/CollisionShape2D.set_deferred("disabled", false)
	
	
