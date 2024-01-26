extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Enter"):
		print("Enter")
		get_tree().quit()

func _on_button_pressed() -> void:
	get_tree().quit()
