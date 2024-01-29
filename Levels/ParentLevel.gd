extends Node2D
class_name Level

signal level_completed

var base_smile_packed = preload("res://Objects/BaseSmile.tscn")

var animated_body

var shakingBody
var droppables: Array = []
var is_shaking: bool = false
var drop_timer: float = 0
const DROP_THESHOLD = 1

var sounds_dict = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var smiles = get_tree().get_nodes_in_group("smiles")
	for smile in smiles:
		connect_signals(smile)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_shaking:
		drop_timer += delta
		if drop_timer >= DROP_THESHOLD:
			drop_item()
			drop_timer -= DROP_THESHOLD
	

func connect_signals(smile) -> void:
	smile.intersected.connect(_on_base_smile_intersected)
	smile.shaking.connect(_on_base_smile_shaked)
	smile.stop_shaking.connect(_on_base_smile_stop_shaking)


func _on_button_pressed() -> void:
	print("button pressed")
	level_completed.emit()


func _on_base_smile_intersected(bodies: Array) -> void:
	pass
	
	
func _on_base_smile_shaked(body) -> void:
	pass
	
	
func _on_base_smile_stop_shaking(body) -> void:
	shakingBody = null
	is_shaking = false
	drop_timer = 0
	
	
func play_sound(path: String) -> void:
	if path:
		if $AudioStreamPlayer2D.is_playing():
			$AudioStreamPlayer2D.stop()
		if path not in sounds_dict:
			sounds_dict[path] = load(path)
		$AudioStreamPlayer2D.stream = sounds_dict[path]
		$AudioStreamPlayer2D.play()
	

func merge_smiles(bodies: Array, names: Array, packed_smile, amount: int = 1,
				sound: String = "") -> bool:
	var count = 0
	var to_delete = []
	var found_tags = []
	for body in bodies:
		if body.tag in names and body.tag not in found_tags:
			count += 1
			to_delete.append(body)
			found_tags.append(body.tag)
	
	if count == len(names):
		for body in to_delete:
			#remove_child(body)
			body.queue_free()
			
	
		for i in range(0, amount):
			var new_smile = packed_smile.instantiate()
			add_child(new_smile)
			
			play_sound(sound)
			
			connect_signals(new_smile)
			new_smile.set_position(get_global_mouse_position() + Vector2(100, 100) * i);
			var tween = create_tween()
			tween.tween_property(new_smile, "scale", Vector2(0.35, 0.35), 0.1)
			tween.tween_property(new_smile, "scale", Vector2(0.3, 0.3), 0.1)
		
		return true

	return false
	
	
func enlarge_emiles(bodies: Array, name: String) -> bool:
	var count = 0
	var to_enlarge
	for body in bodies:
		if body.tag == name:
			count += 1
			to_enlarge = body
		if body.tag == "MagnifyingGlass":
			count += 1
	
	if count == 2:
		var tween = create_tween()
		var new_scale = to_enlarge.scale * 2
		tween.tween_property(to_enlarge, "scale", Vector2(0.25, 0.25), 0.1)
		tween.tween_property(to_enlarge, "scale", new_scale, 0.1)
		play_sound("res://Assets/Sounds/zoom in.mp3")
		#to_enlarge.scale = Vector2(to_enlarge.scale * 1.5)
		return true

	return false
	

func init_item_drop(body, items: Array) -> void:
	shakingBody = body
	droppables = items
	
	
func drop_item():
	if shakingBody.isOneTimeShakable && shakingBody.isShaked:
		return
		
	if len(droppables) > 0:
		var packed = droppables.pop_front()
		var new_smile = packed.instantiate()
		add_child(new_smile)
		connect_signals(new_smile)
		new_smile.set_position(shakingBody.position)
		var tween = create_tween()
		tween.tween_property(new_smile, "scale", Vector2(0.35, 0.35), 0.1)
		tween.set_parallel(true)
		tween.tween_property(new_smile, "scale", Vector2(0.3, 0.3), 0.1)
		tween.tween_property(new_smile, "position", new_smile.position + Vector2(0, 200), 0.2).set_ease(Tween.EASE_OUT)
	
	if len(droppables) == 0 and shakingBody.isOneTimeShakable:
		shakingBody.isShaked = true
		

func spawn_boar(bodies,
				name1: String, del1: bool,
				name2: String, del2: bool,
				packed_smile):
	
	var count = 0
	var to_delete = []
	var start_position
	for body in bodies:
		if body.tag == name1:
			if del1:
				to_delete.append(body)
			count += 1
			start_position = body.position
		if body.tag == name2:
			if del2:
				to_delete.append(body)
			count += 1
	
	if count == 2:
		for body in to_delete:
			body.queue_free()
		
		var new_smile = packed_smile.instantiate()
		add_child(new_smile)
		connect_signals(new_smile)
		
		new_smile.set_position(start_position)
		var new_position = start_position - Vector2(1920, 0)
		var tween = create_tween()
		tween.tween_property(new_smile, "scale", Vector2(0.35, 0.35), 0.1)
		tween.tween_property(new_smile, "scale", Vector2(0.3, 0.3), 0.1)
		tween.tween_property(new_smile, "position", new_position, 5).connect("finished", on_tween_finished)
		animated_body = new_smile
		return true

	return false
	
func on_tween_finished():
	if animated_body:
		animated_body.queue_free()
		animated_body = null
		
		
func spawn_item(bodies,
				name1: String, del1: bool,
				name2: String, del2: bool,
				packed_smile,
				audio_path:String = ""):
	
	var count = 0
	var to_delete = []
	var start_position
	var found_tags = []
	for body in bodies:
		if body.tag == name1 and body.tag not in found_tags:
			if del1:
				to_delete.append(body)
			count += 1
			start_position = body.position
			found_tags.append(body.tag)
		if body.tag == name2 and body.tag not in found_tags:
			if del2:
				to_delete.append(body)
			count += 1
			found_tags.append(body.tag)
	
	if count == 2:
		for body in to_delete:
			body.queue_free()
		
		var new_smile = packed_smile.instantiate()
		add_child(new_smile)
		connect_signals(new_smile)
		
		play_sound(audio_path)
		
		new_smile.set_position(start_position)
		var tween = create_tween()
		tween.tween_property(new_smile, "scale", Vector2(0.35, 0.35), 0.1)
		tween.tween_property(new_smile, "scale", Vector2(0.3, 0.3), 0.1)
		return true

	return false
	
