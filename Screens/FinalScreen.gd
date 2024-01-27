extends Node2D

const UNICORNS_COUNT = 6

@onready var unicorns_timer = $Timer
@onready var partying_face = $PartyingFace

var unicorns_scene = load("res://Screens/Unicorns.tscn")
var unicorns_herd: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#_on_timer_timeout()
	
	var tween = get_tree().create_tween().bind_node(partying_face) \
		.set_loops() \
		.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(partying_face, "position:y", -100, 1).as_relative()
	tween.tween_property(partying_face, "position:y", 100.0, 1).as_relative()
	tween.tween_callback(func(): partying_face.flip_h = not partying_face.flip_h)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var screen_size = get_viewport_rect().size
	for unicorns in unicorns_herd:
		var unicorns_size = screen_size * unicorns.scale
		var x = screen_size.x / 2 - unicorns_size.x / 2
		var y = screen_size.y - unicorns_size.y
		unicorns.position = Vector2(x, y)
	
	if Input.is_action_just_pressed("Enter") or Input.is_action_just_pressed("exit"):
		print("Enter")
		get_tree().quit()


func _on_button_pressed() -> void:
	get_tree().quit()


func _on_timer_timeout():
	if len(unicorns_herd) < UNICORNS_COUNT:
		var unicorns = unicorns_scene.instantiate()
		add_child(unicorns)
		
		unicorns.play()
		unicorns.scale = Vector2(0, 0)
		
		var tween = get_tree().create_tween().bind_node(unicorns) \
			.set_loops() \
			.set_trans(Tween.TRANS_LINEAR) \
			.set_parallel(true)
		tween.tween_callback(unicorns.play)
		tween.tween_callback(unicorns.move_to_front)
		
		var time = unicorns_timer.wait_time * 3
		tween.tween_property(unicorns, "scale", Vector2(3, 3), time).from_current()
		tween.tween_property(unicorns, "modulate:a", 0, time).from_current()
		unicorns_herd.append(unicorns)
	else:
		unicorns_timer.stop()
