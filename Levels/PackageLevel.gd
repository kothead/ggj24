extends Level


var roflFacePacked = load("res://Objects/ROFLFace.tscn")
var joystickPacked = load("res://Objects/Joystick.tscn")

enum Stages {None, Game, Rofl}
var stage = Stages.None

func _on_base_smile_intersected(bodies: Array) -> void:
	if stage == Stages.None:
		if merge_smiles(bodies, ["Scissors", "Package"], joystickPacked):
			stage = Stages.Game
				
	if stage == Stages.Game:
		if merge_smiles(bodies, ["PokerFace", "Joystick"], roflFacePacked):
			stage = Stages.Rofl
			level_completed.emit()
