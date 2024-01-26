extends Level

var smilyFacePacked = load("res://Objects/SmilyFace.tscn")
var roflFacePacked = load("res://Objects/ROFLFace.tscn")

enum Stages {None, Smily, Rofl}
var stage = Stages.None

func _on_base_smile_intersected(bodies: Array) -> void:
	if stage == Stages.None:
		if merge_smiles(bodies, ["PokerFace", "Pizza"], smilyFacePacked) \
				or merge_smiles(bodies, ["PokerFace", "Joystick"], smilyFacePacked):
			stage = Stages.Smily
				
	if stage == Stages.Smily:
		if merge_smiles(bodies, ["SmilyFace", "Pizza"], roflFacePacked) \
				or merge_smiles(bodies, ["SmilyFace", "Joystick"], roflFacePacked):
			stage = Stages.Rofl
			level_completed.emit()
		
	
