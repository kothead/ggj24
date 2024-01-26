@tool
extends Node2D

var draggable: bool = false
var offset: Vector2
	
@export_file("*.png") var image_path: String

signal intersected(bodies: Array)

func _ready() -> void:
	var new_texture = load(image_path)
	$Sprite2D.set_texture(new_texture)
	

func set_texture(image_path: String) -> void:
	var new_texture = load(image_path)
	$Sprite2D.set_texture(new_texture)

	
func _process(delta: float) -> void:
	if draggable and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		global_position = get_global_mouse_position() - offset
	
	
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if not global.is_dragging:
				global.is_dragging = true
				draggable = true
				offset = get_global_mouse_position() - global_position
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			global.is_dragging = false
			draggable = false
			for area in $Area2D.get_overlapping_areas():
				var bodies: Array = []
				if area.get_parent().is_in_group("droppable"):
					bodies.append(area.get_parent())
				intersected.emit(bodies)


func _on_area_2d_mouse_entered() -> void:
	if not global.is_dragging:
		scale = Vector2(1.05, 1.05)


func _on_area_2d_mouse_exited() -> void:
	if not global.is_dragging:
		scale = Vector2(1, 1)
