extends CharacterBody2D


var is_dragging = false
var draggable = false

signal dragsignal

func _ready() -> void:
	dragsignal.connect(_set_drag)
	
	
func _process(delta: float) -> void:
	if is_dragging:
		var mousepos = get_global_mouse_position()
		self.position = Vector2(mousepos.x, mousepos.y)
	
	
func _set_drag():
	is_dragging = !is_dragging
	

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			emit_signal("dragsignal")
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			emit_signal("dragsignal")
	
	


func _on_mouse_entered() -> void:
	if not global.is_dragging:
		draggable = true
		scale = Vector2(1.05, 1.05)


func _on_mouse_exited() -> void:
	if not global.is_dragging:
		draggable = false
		scale = Vector2(1, 1)
		


		
	
