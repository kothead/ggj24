extends Level


var smilyFacePacked = load("res://Objects/SmilyFace.tscn")
var roflFacePacked = load("res://Objects/ROFLFace.tscn")
var pizzaPacked = load("res://Objects/Pizza.tscn")

enum Stages {None, Pizza, BigPizza, Rofl}
var stage = Stages.None

func _on_base_smile_intersected(bodies: Array) -> void:
	if stage == Stages.None:
		if merge_smiles(bodies, ["Flatbread", "Cheese"], pizzaPacked):
			stage = Stages.Pizza
			
	if stage == Stages.Pizza:
		if merge_smiles(bodies, ["PokerFace", "Pizza"], smilyFacePacked):
			pass
		elif enlarge_emiles(bodies, "Pizza"):
			stage = Stages.BigPizza
				
	if stage == Stages.BigPizza:
		if merge_smiles(bodies, ["PokerFace", "Pizza"], roflFacePacked):
			stage = Stages.Rofl
			level_completed.emit()
		
	
