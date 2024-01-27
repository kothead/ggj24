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
	if merge_smiles(bodies, ["Shovel", "Headstone"], coffinPacked, 2,
					"res://Assets/Sounds/shovel+headstone.mp3"):
		pass
		
	if spawn_item(bodies, "ZombieMan", true, "Dagger", false, brainPacked,
				  "res://Assets/Sounds/zombie+dagger.mp3"):
		pass
		
	elif spawn_item(bodies, "ZombieWoman", true, "Dagger", false, heartPacked,
				  "res://Assets/Sounds/zombie+dagger.mp3"):
		pass
		
	if merge_smiles(bodies, ["Robot", "Brain"], robotHumanPacked, 1,
					"res://Assets/Sounds/robot+organ.mp3") \
			or merge_smiles(bodies, ["Robot", "Heart"], robotHumanPacked, 1,
							"res://Assets/Sounds/robot+organ.mp3"):
		pass
		
	elif merge_smiles(bodies, ["RobotHuman", "Brain"], pokerFacePacked, 1,
					"res://Assets/Sounds/robot+organ.mp3") \
			or merge_smiles(bodies, ["RobotHuman", "Heart"], pokerFacePacked, 1,
					"res://Assets/Sounds/robot+organ.mp3"):
		pass
		
	if merge_smiles(bodies, ["PokerFace", "Pizza"], smilyFacePacked, 1,
					"res://Assets/Sounds/pizza+char.mp3") \
			or merge_smiles(bodies, ["PokerFace", "Joystick"], smilyFacePacked, 1,
							"res://Assets/Sounds/8-bit-game-2-186976.mp3"):
		pass
		
	elif merge_smiles(bodies, ["SmilyFace", "Pizza"], roflFacePacked, 1,
					"res://Assets/Sounds/pizza+char.mp3") \
			or merge_smiles(bodies, ["SmilyFace", "Joystick"], roflFacePacked, 1,
							"res://Assets/Sounds/8-bit-game-2-186976.mp3"):
		level_completed.emit()


func _on_base_smile_shaked(body) -> void:
	if body.tag == "Coffin":
		is_shaking = true
		init_item_drop(body, [zombie1Packed if zombies == 0 else zombie2Packed])
		zombies += 1
		
		
	
