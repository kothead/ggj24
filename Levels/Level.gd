extends Level

var smilyFacePacked = load("res://Objects/SmilyFace.tscn")
var roflFacePacked = load("res://Objects/ROFLFace.tscn")

enum Stages {None, Smily, Rofl}
var stage = Stages.None

func _on_base_smile_intersected(bodies: Array) -> void:
	if stage == Stages.None:
		if merge_smiles(bodies, ["PokerFace", "Pizza"], smilyFacePacked, 1,
						"res://Assets/Sounds/pizza+char.mp3") \
				or merge_smiles(bodies, ["PokerFace", "Joystick"], smilyFacePacked, 1,
								"res://Assets/Sounds/videogame+char.mp3"):
			stage = Stages.Smily
				
	if stage == Stages.Smily:
		if merge_smiles(bodies, ["SmilyFace", "Pizza"], roflFacePacked, 1,
						"res://Assets/Sounds/pizza+char.mp3") \
				or merge_smiles(bodies, ["SmilyFace", "Joystick"], roflFacePacked, 1,
								"res://Assets/Sounds/videogame+char.mp3"):
			stage = Stages.Rofl
			level_completed.emit()
		
	
