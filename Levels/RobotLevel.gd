extends Level


var robotHumanPacked = load("res://Objects/RobotHuman.tscn")
var pokerFacePacked = load("res://Objects/PokerFace.tscn")
var smilyFacePacked = load("res://Objects/SmilyFace.tscn")
var roflFacePacked = load("res://Objects/ROFLFace.tscn")

var coffinPacked = load("res://Objects/Coffin.tscn")
var zombie1Packed = load("res://Objects/ZombieMan.tscn")
var zombie2Packed = load("res://Objects/ZombieWoman.tscn")

var brainPacked = load("res://Objects/Brain.tscn")
var heartPacked = load("res://Objects/Heart.tscn")

var zombies = 0

func _on_base_smile_intersected(bodies: Array) -> void:
	if merge_smiles(bodies, ["Shovel", "Headstone"], coffinPacked, 2):
		pass
		
	if spawn_item(bodies, "ZombieMan", true, "Dagger", false, brainPacked):
		pass
		
	if spawn_item(bodies, "ZombieWoman", true, "Dagger", false, heartPacked):
		pass
		
	if merge_smiles(bodies, ["Robot", "Brain"], robotHumanPacked) \
			or merge_smiles(bodies, ["Robot", "Heart"], robotHumanPacked):
		pass
		
	if merge_smiles(bodies, ["RobotHuman", "Brain"], pokerFacePacked) \
			or merge_smiles(bodies, ["RobotHuman", "Heart"], pokerFacePacked):
		pass
		
	if merge_smiles(bodies, ["PokerFace", "Pizza"], smilyFacePacked) \
			or merge_smiles(bodies, ["PokerFace", "Joystick"], smilyFacePacked):
		pass
		
	if merge_smiles(bodies, ["SmilyFace", "Pizza"], roflFacePacked) \
			or merge_smiles(bodies, ["SmilyFace", "Joystick"], roflFacePacked):
		level_completed.emit()


func _on_base_smile_shaked(body) -> void:
	if body.tag == "Coffin":
		is_shaking = true
		init_item_drop(body, [zombie1Packed if zombies == 0 else zombie2Packed])
		zombies += 1
		
		
	
