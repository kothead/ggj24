extends Level


var happyFacePacked = load("res://Objects/HappyFace.tscn")
var smilyFacePacked = load("res://Objects/SmilyFace.tscn")
var roflFacePacked = load("res://Objects/ROFLFace.tscn")

var candyPacked = load("res://Objects/Candy.tscn")
var lollipopPacked = load("res://Objects/Lollipop.tscn")
var scissorsPacked = load("res://Objects/Scissors.tscn")
var joystickPacked = load("res://Objects/Joystick.tscn")


func _ready() -> void:
	super._ready()
	droppables = [candyPacked, lollipopPacked, scissorsPacked]

func _on_base_smile_shaked(body) -> void:
	if body.tag == "Pinata":
		is_shaking = true
		init_item_drop(body, droppables)
			

func _on_base_smile_intersected(bodies: Array) -> void:
	if merge_smiles(bodies, ["Scissors", "Package"], joystickPacked):
		pass
	
	if merge_smiles(bodies, ["PokerFace", "Joystick"], happyFacePacked) \
			or merge_smiles(bodies, ["PokerFace", "Candy"], happyFacePacked) \
			or merge_smiles(bodies, ["PokerFace", "Lollipop"], happyFacePacked):
		pass

	if merge_smiles(bodies, ["HappyFace", "Joystick"], smilyFacePacked) \
			or merge_smiles(bodies, ["HappyFace", "Candy"], smilyFacePacked) \
			or merge_smiles(bodies, ["HappyFace", "Lollipop"], smilyFacePacked):
		pass

	if merge_smiles(bodies, ["SmilyFace", "Joystick"], roflFacePacked) \
			or merge_smiles(bodies, ["SmilyFace", "Candy"], roflFacePacked) \
			or merge_smiles(bodies, ["SmilyFace", "Lollipop"], roflFacePacked):
		level_completed.emit()
		
