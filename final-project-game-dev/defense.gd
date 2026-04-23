extends CharacterBody2D

signal hit_player


func _ready():
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()
	$Hitbox_Diving/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2Diving.set_deferred("disabled", true)
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

func _on_hitbox_body_entered(body: Node2D) -> void:
	hit_player.emit()
	
func _on_hitbox_diving_body_entered(body: Node2D) -> void:
	hit_player.emit()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	$Hitbox_Normal/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2Diving.set_deferred("disabled", false)
	$AnimatedSprite2D.animation = "diving"
	$AnimatedSprite2D.play()
	$Hitbox_Diving/CollisionShape2D.set_deferred("disabled", false)
	
	
