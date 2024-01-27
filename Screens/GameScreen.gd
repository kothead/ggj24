extends Node2D


@onready var level_container: Node2D = $LevelContainer
@onready var next_overlay: Node2D = $NextConatiner
@onready var left_unicorn = $NextConatiner/LeftUnicorn
@onready var right_unicorn = $NextConatiner/RightUnicorn


var current_level_id: int = 0
var current_level: Node2D = null

var levels: Array = [
	preload("res://Levels/DessertLevel.tscn"),
	preload("res://Levels/HungryLevel.tscn"),
	preload("res://Levels/Level.tscn"),
	preload("res://Levels/PackageLevel.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_level(current_level)


func load_level(level_id) -> void:
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


func _on_button_pressed() -> void:
	load_level(current_level)
	
	
func _on_level_completed() -> void:
	print("on level completed")
	current_level_id += 1
	next_overlay.visible = true
	left_unicorn.play("unicorn_show")
	right_unicorn.play("unicorn_show")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Restart") && not $NextConatiner.visible:
		global.is_dragging = false
		load_level(current_level_id)
	if Input.is_action_just_pressed("Enter") && $NextConatiner.visible:
		load_level(current_level)


func _on_left_unicorn_animation_finished():
	left_unicorn.play("unicorn_loop")


func _on_right_unicorn_animation_finished():
	right_unicorn.play("unicorn_loop")
