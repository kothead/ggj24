extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _get_drag_data(_position):
	print(_position)
	
# Control that can be dragged to
func _can_drop_data(at_position:Vector2, data:Variant)->bool:
	return false
	
func _drop_data(at_position:Vector2, data:Variant)->void:
	pass
