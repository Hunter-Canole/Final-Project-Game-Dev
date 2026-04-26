extends Node
var lives = 3
var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(-1)

func goto_scene(path, camera):
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "zoom", Vector2(10, 10), 4)
	tween.tween_callback(func(): call_deferred("_deferred_goto_scene", path))
	
func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
