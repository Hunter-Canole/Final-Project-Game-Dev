extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -700.0
@export var MAX_COYOTE_FRAMES = 100.0
@export var timer_delay = 0.5
@export var MAX_INPUT_BUFFER_FRAMES = 100


var coyote_frames = 0
var input_buffer_frames = 0;
var believe_in_gravity = false
var is_jumping = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$AnimatedSprite2D.animation = 'idle'
	$AnimatedSprite2D.play()


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		#coyote_frames +=1
		if $WileTimer.is_stopped():
			$WileTimer.start(timer_delay)
		if Input.is_action_just_pressed('ui_accept'):
			input_buffer_frames = MAX_INPUT_BUFFER_FRAMES
		if input_buffer_frames > 0 :
			input_buffer_frames -= 1
	else:
		coyote_frames = 0
		is_jumping = false
		believe_in_gravity = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") or input_buffer_frames > 0:
		if is_jumping == false and not believe_in_gravity:
			velocity.y = JUMP_VELOCITY
			is_jumping = true

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0
	if not is_on_floor():
		$AnimatedSprite2D.play("Hurdle")
	elif direction:
		$AnimatedSprite2D.play("Run")
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		$AnimatedSprite2D.play("Idle")

	move_and_slide()

func ow():
	queue_free()

func bounce():
	velocity.y = JUMP_VELOCITY/1.5

func set_pos(pos):
	position=pos


func _on_wile_timer_timeout() -> void:
	believe_in_gravity = true
