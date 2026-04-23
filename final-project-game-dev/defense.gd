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
	# 1. Disable the top hurtbox so this doesn't run twice
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	$Hitbox_Normal/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2Diving.set_deferred("disabled", false)
	# 3. Change states
	$AnimatedSprite2D.animation = "diving"
	$AnimatedSprite2D.play()
	# 4. Wait just a tiny bit before making the enemy "deadly" again
	# This gives the player time to clrear the area
	await get_tree().create_timer(0.7).timeout
	$Hitbox_Diving/CollisionShape2D.set_deferred("disabled", false)
	
	
