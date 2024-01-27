extends Level


var smilyFacePacked = load("res://Objects/SmilyFace.tscn")
var roflFacePacked = load("res://Objects/ROFLFace.tscn")
var pizzaPacked = load("res://Objects/Pizza.tscn")

enum Stages {None, Pizza, BigPizza, Rofl}
var stage = Stages.None

func _on_base_smile_intersected(bodies: Array) -> void:
	if stage == Stages.None:
		if merge_smiles(bodies, ["Flatbread", "Cheese"], pizzaPacked, 1,
						"res://Assets/Sounds/cheese+flatbread.mp3"):
			stage = Stages.Pizza
			
	if stage == Stages.Pizza:
		if merge_smiles(bodies, ["PokerFace", "Pizza"], smilyFacePacked, 1,
						"res://Assets/Sounds/pizza+char.mp3"):
			pass
		elif enlarge_emiles(bodies, "Pizza"):
			stage = Stages.BigPizza
				
	if stage == Stages.BigPizza:
		if merge_smiles(bodies, ["PokerFace", "Pizza"], roflFacePacked, 1,
						"res://Assets/Sounds/pizza+char.mp3"):
			stage = Stages.Rofl
			level_completed.emit()
		
	
