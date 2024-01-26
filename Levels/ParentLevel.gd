extends Node2D
class_name Level

signal level_completed

var base_smile_packed = preload("res://Objects/BaseSmile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	print("button pressed")
	level_completed.emit()


func _on_base_smile_intersected(bodies: Array) -> void:
	for body in bodies:
		remove_child(body)
	var new_smile = base_smile_packed.instantiate()
	new_smile.image_path = "res://Assets/Images/1F923_color.png"
	new_smile.set_position(get_global_mouse_position())
	add_child(new_smile)
	
