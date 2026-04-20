extends CharacterBody2D

signal hit_player

var is_diving = false

func _ready():
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()
	$Hitbox_Diving/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2Diving.set_deferred("disabled", true)
func _physics_process(delta: float) -> void:
	if is_diving:
		velocity.x = 0
		velocity.y = 1200
	else:
		if not is_on_floor():
			velocity += get_gravity() * delta

	move_and_slide()

func _on_hitbox_body_entered(body: Node2D) -> void:
	hit_player.emit()
	print("HITBOX TRIGGERED")

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if is_diving:
		return
		
	is_diving = true
	$Hitbox_Normal/CollisionShape2D.set_deferred("disabled", true)
	$Hitbox_Diving/CollisionShape2D.set_deferred("disabled", false)
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2Diving.set_deferred("disabled", false)
	$CollisionShape2D.set_deferred("disabled", true)

	# Play animation
	$AnimatedSprite2D.animation = "diving"
	$AnimatedSprite2D.play()


func _on_hitbox_diving_body_entered(body: Node2D) -> void:
	hit_player.emit()
	print("HITBOX TRIGGERED")
