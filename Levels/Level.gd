extends Level

var smilyFacePacked = load("res://Objects/SmilyFace.tscn")
var roflFacePacked = load("res://Objects/ROFLFace.tscn")

func _on_base_smile_intersected(bodies: Array) -> void:
	print("_on_base_smile_intersected")
	for body in bodies:
		print(body.tag)
	var merged = merge_smiles(bodies, ["PokerFace", "Pizza"], smilyFacePacked)
	if not merged:
		merge_smiles(bodies, ["PokerFace", "Joystick"], smilyFacePacked)
		
	merged = merge_smiles(bodies, ["SmilyFace", "Pizza"], smilyFacePacked)
	if not merged:
		merge_smiles(bodies, ["SmilyFace", "Joystick"], roflFacePacked)
		
	
