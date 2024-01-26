extends Node2D
class_name Level

signal level_completed

var base_smile_packed = preload("res://Objects/BaseSmile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var smiles = get_tree().get_nodes_in_group("smiles")
	for smile in smiles:
		connect_signals(smile)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func connect_signals(smile) -> void:
	smile.intersected.connect(_on_base_smile_intersected)


func _on_button_pressed() -> void:
	print("button pressed")
	level_completed.emit()


func _on_base_smile_intersected(bodies: Array) -> void:
	pass
	

func merge_smiles(bodies: Array, names: Array, packed_smile) -> bool:
	var count = 0
	var to_delete = []
	for body in bodies:
		if body.tag  in names:
			count += 1
			to_delete.append(body)
	
	if count == len(names):
		for body in to_delete:
			remove_child(body)
	
		var new_smile = packed_smile.instantiate()
		connect_signals(new_smile)
		new_smile.set_position(get_global_mouse_position())
		add_child(new_smile)
		
		return true

	return false	
	
	
