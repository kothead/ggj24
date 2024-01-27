extends CharacterBody2D
class_name Smile

const TIME_TO_DROP_WITHOUT_MOUSE = 0.2
const SHAKE_TIME = 0.5
const SHAKE_SPEED_THRESHOLD: int = 500

var dragging: bool = false
var previous_mouse_position: Vector2
var mouse_left_for: float = 0
var mouse_on = false

var x_speeds: Array = []
var y_speeds: Array = []
var previous_position: Vector2
var is_shaking = false

@onready var sprite_2d = $Sprite2D
@onready var area_2d = $Area2D

@export_file("*.png") var image_path: String

@export var tag: String
@export var can_move: bool = true

signal intersected(bodies: Array)
signal shaking(body: Node)
signal stop_shaking(body: Node)


func _ready() -> void:
	scale = Vector2(0.3, 0.3)
	previous_position = position
	

func set_texture(image_path: String) -> void:
	var new_texture = load(image_path)
	sprite_2d.set_texture(new_texture)
	

func process_shaking(delta: float, distance: float, speeds: Array):
	if not can_move:
		return
		
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


func _physics_process(delta):
	if not can_move:
		return
	
	if dragging:
		if mouse_left_for > TIME_TO_DROP_WITHOUT_MOUSE:
			on_drop()
		else:
			var mouse_position = get_global_mouse_position()
			velocity = (mouse_position - previous_mouse_position) / delta
			previous_mouse_position = mouse_position
			move_and_slide()

func detect_shaking(delta: float):
	var dx = position.x - previous_position.x
	var dy = position.y - previous_position.y
	process_shaking(delta, dx, x_speeds)
	process_shaking(delta, dy, y_speeds)
			
	if len(x_speeds) >= 3 || len(y_speeds) >= 3:
		if not is_shaking:
			is_shaking = true
			shaking.emit(self)
			print("I'm shaking")
	else:
		if is_shaking:
			is_shaking = false
			stop_shaking.emit(self)
			print("I'm not shaking anymore")
			
	previous_position = position


func _process(delta: float) -> void:
	if not can_move:
		return
		
	if not mouse_on:
		mouse_left_for += delta
	
	detect_shaking(delta)


func _on_mouse_entered():
	if not can_move:
		return
		
	mouse_on = true
	mouse_left_for = 0


func _on_mouse_exited():
	if not can_move:
		return
		
	mouse_on = false


func on_drop():
	if dragging:
		check_intersections()
	dragging = false
	global.is_dragging = false
	

func check_intersections():
	var bodies: Array = []
	bodies.append(self)
	for area in area_2d.get_overlapping_areas():
		if area.get_parent().is_in_group("smiles"):
			bodies.append(area.get_parent())
	intersected.emit(bodies)


func _on_input_event(viewport, event, shape_idx):
	if not can_move:
		return
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if not global.is_dragging:
				global.is_dragging = true
				dragging = true
				previous_mouse_position = get_global_mouse_position()
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			on_drop()
			
