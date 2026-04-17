extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	
func _ready():
	$AnimatedSprite2D.animation = 'idle'
	$AnimatedSprite2D.play()

func _on_hitbox_body_entered(body: Node2D) -> void:
	hit_player.emit()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	$AnimatedSprite2D.animation = 'diving'
	$AnimatedSprite2D.play()
