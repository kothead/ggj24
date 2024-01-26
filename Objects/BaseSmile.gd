extends Node2D

var draggable: bool = false
var offset: Vector2

var x_speeds: Array = []
var y_speeds: Array = []
var previous_position: Vector2

var SHAKE_TIME = 0.5
var SHAKE_SPEED_THRESHOLD: int = 500

var is_shaking = false
	
@export_file("*.png") var image_path: String

signal intersected(bodies: Array)
signal shaking(body: Node)
signal stop_shaking(body: Node)

func _ready() -> void:
	var new_texture = load(image_path)
	$Sprite2D.set_texture(new_texture)
	previous_position = position
	

func set_texture(image_path: String) -> void:
	var new_texture = load(image_path)
	$Sprite2D.set_texture(new_texture)
	

func detect_shaking(delta: float, distance: float, speeds: Array):
	for i in range(len(speeds) - 1, -1, -1):
		var speed = speeds[i]
		speed[1] += delta
		if speed[1] > SHAKE_TIME:
			speeds.remove_at(i)
	
	var speed = distance / delta
	var previus_speed = speeds[len(speeds) - 1][0] if speeds else null
	
	#print("Previus speed " + str(previus_speed) + " vs speed " + str(speed))
	if abs(speed) > SHAKE_SPEED_THRESHOLD and \
		(previus_speed == null  \
		or sign(previus_speed) != sign(speed)):
			speeds.append([speed, 0])
			
	if len(speeds) >= 3:
		if not is_shaking:
			is_shaking = true
			shaking.emit(self)
			print("I'm shaking")
	else:
		if is_shaking:
			is_shaking = false
			stop_shaking.emit(self)
			print("I'm not shaking anymore")

	
func _process(delta: float) -> void:
	var dx = position.x - previous_position.x
	var dy = position.y - previous_position.y
	detect_shaking(delta, dx, x_speeds)
	detect_shaking(delta, dy, y_speeds)
	previous_position = position	
	
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
				bodies.append(self)
				if area.get_parent().is_in_group("droppable"):
					bodies.append(area.get_parent())
				intersected.emit(bodies)


func _on_area_2d_mouse_entered() -> void:
	if not global.is_dragging:
		scale = Vector2(1.05, 1.05)


func _on_area_2d_mouse_exited() -> void:
	print("exited")
	if not global.is_dragging:
		scale = Vector2(1, 1)


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
	
