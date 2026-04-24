extends Node2D

var lives
var can_be_hit = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.set_physics_process(false)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func game_over() -> void:
	$Player.set_physics_process(false)
	$Player/AnimatedSprite2D.stop()
	$HUD/Lives.visible = false
	$HUD.show_game_over()
	
func new_game():
	$Player.show()
	lives = 3
	$Player.set_physics_process(true)
	can_be_hit = true
	$HUD/Lives.visible = true
	$HUD/Lives.text = "Lives: " + str(lives)
	$Player.position = $PlayerSpawn.position
	get_tree().call_group("defense", "queue_free")


func _on_defense_hit_player() -> void:
	if not can_be_hit:
		return 
	can_be_hit = false
	$Player.hide()
	lives -= 1
	$HUD/Lives.text = "Lives: " + str(lives)
	$Player.position = $PlayerSpawn.position
	if lives <= 0:
		game_over()
	else:
		await get_tree().create_timer(1.2).timeout
		$Player.show()
		can_be_hit = true
func _on_hud_start_game() -> void:
	new_game()


func _on_jump_defender_hit_player() -> void:
	if not can_be_hit:
		return 
	can_be_hit = false
	$Player.hide()
	lives -= 1
	$HUD/Lives.text = "Lives: " + str(lives)
	$Player.position = $PlayerSpawn.position
	if lives <= 0:
		game_over()
	else:
		await get_tree().create_timer(1.2).timeout
		$Player.show()
		can_be_hit = true
