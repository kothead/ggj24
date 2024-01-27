extends Node2D


@onready var level_container: Node2D = $LevelContainer
@onready var next_overlay: Node2D = $NextConatiner
@onready var rofl = $NextConatiner/Rofl
@onready var unicorns = $NextConatiner/Unicorns


var current_level_id: int = 0
var current_level: Node2D = null
var can_go_next_level = false
var rofl_tween_enter
var rofl_tween_rotate

var levels: Array = [
	preload("res://Levels/Level.tscn"),
	preload("res://Levels/PackageLevel.tscn"),
	preload("res://Levels/HungryLevel.tscn"),
	preload("res://Levels/DessertLevel.tscn"),
	preload("res://Levels/SocialMediaLevel.tscn"),
	preload("res://Levels/AnimalsLevel.tscn"),
	preload("res://Levels/AlienLevel.tscn"),
	preload("res://Levels/RobotLevel.tscn"),
	preload("res://Levels/CowLevel.tscn"),
	preload("res://Levels/FinalLevel.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_level(current_level)


func load_level(level_id) -> void:
	can_go_next_level = false
	
	if current_level_id == len(levels):
		get_tree().change_scene_to_file("res://Screens/FinalScreen.tscn")
		return
		
	if current_level:
		current_level.level_completed.disconnect(_on_level_completed)
		level_container.remove_child(current_level)
		
	current_level = levels[current_level_id].instantiate()
	current_level.level_completed.connect(_on_level_completed)
	level_container.add_child(current_level)
	next_overlay.visible = false


func _unhandled_input(event):
	if can_go_next_level and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			load_level(current_level)
	
	
func _on_level_completed() -> void:
	print("on level completed")
	$AudioStreamPlayer2D.play()
	current_level_id += 1
	next_overlay.visible = true
	unicorns.play()
	show_rofl()


func show_rofl():
	if rofl_tween_enter:
		rofl_tween_enter.kill()
	if rofl_tween_rotate:
		rofl_tween_rotate.kill()
	
	rofl.scale = Vector2(0, 0)
	rofl_tween_enter = get_tree().create_tween() \
		.bind_node(rofl) \
		.set_trans(Tween.TRANS_CUBIC)
	rofl_tween_enter.tween_property(rofl, "scale", Vector2(1.0, 1.0), 1)
	rofl_tween_enter.tween_callback(func(): can_go_next_level = true)
	
	rofl.rotation = 0
	rofl_tween_rotate = get_tree().create_tween().bind_node(rofl) \
		.set_trans(Tween.TRANS_LINEAR) \
		.set_loops()
	rofl_tween_rotate.tween_property(rofl, "rotation", 2 * PI, 3).from_current()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Restart") && not $NextConatiner.visible:
		global.is_dragging = false
		load_level(current_level_id)
	if Input.is_action_just_pressed("Enter") && $NextConatiner.visible:
		load_level(current_level)
