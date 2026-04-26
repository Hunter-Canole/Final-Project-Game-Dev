extends Node2D

var lives
var can_be_hit = true
func _ready() -> void:
	start_level_immediately()
func _process(delta: float) -> void:
	pass
func game_over() -> void:
	$CrowdNoise.stop()
	$Player.set_physics_process(false)
	$Player/AnimatedSprite2D.stop()
	$HUD/Lives.visible = false
	$HUD.show_game_over()
func start_level_immediately():
	$Player.show()
	$Player.set_physics_process(true)
	can_be_hit = true
	$HUD/Lives.visible = true
	$HUD/Lives.text = "Lives: " + str(Global.lives)
	$HUD/StartButton.hide()
	$HUD/Message.hide()
	$Player.position = $PlayerSpawn.position
	$CrowdNoise.play()
	
func new_game():
	Global.goto_scene("res://world.tscn", $Player/Camera2D)
	$Player.show()
	Global.lives = 3
	$Player.set_physics_process(true)
	can_be_hit = true
	$HUD/Lives.visible = true
	$HUD/Lives.text = "Lives: " + str(Global.lives)
	$Player.position = $PlayerSpawn.position
	get_tree().call_group("defense", "queue_free")
	$Whistle.play()
	$CrowdNoise.play()


func _on_defense_hit_player() -> void:
	$CrowdNoise.stop()
	$Pads.play()
	$Whistle.play()
	if not can_be_hit:
		return 
	can_be_hit = false
	$Player.hide()
	Global.lives -= 1
	$HUD/Lives.text = "Lives: " + str(Global.lives)
	$Player.position = $PlayerSpawn.position
	if Global.lives <= 0:
		game_over()
	else:
		await get_tree().create_timer(1.2).timeout
		$Player.show()
		can_be_hit = true
	$CrowdNoise.play()
func _on_hud_start_game() -> void:
	new_game()


func _on_jump_defender_hit_player() -> void:
	if not can_be_hit:
		return 
	can_be_hit = false
	$Player.hide()
	$Pads.play()
	$Whistle.play()
	Global.lives -= 1
	$HUD/Lives.text = "Lives: " + str(Global.lives)
	$Player.position = $PlayerSpawn.position
	if Global.lives <= 0:
		game_over()
	else:
		await get_tree().create_timer(1.2).timeout
		$Player.show()
		can_be_hit = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_enter_endzone_body_entered(body: Node2D) -> void:
	Global.goto_scene("res://lvl_4.tscn", $Player/Camera2D)
