extends Level


var happyFacePacked = load("res://Objects/HappyFace.tscn")
var smilyFacePacked = load("res://Objects/SmilyFace.tscn")
var roflFacePacked = load("res://Objects/ROFLFace.tscn")

var alientPacked = load("res://Objects/Alien.tscn")
var alienMonsterPacked = load("res://Objects/AlienMonster.tscn")
var airplanePacked = load("res://Objects/Airplane.tscn")
var spaceShipPacked = load("res://Objects/SpaceShip.tscn")
var flyiingSaurcerPacked = load("res://Objects/FlyingSaucer.tscn")
var hundredPointsPacked = load("res://Objects/HundredPoints.tscn")


func _ready() -> void:
	super._ready()
	droppables = [alientPacked, alienMonsterPacked, airplanePacked, alienMonsterPacked, alienMonsterPacked]
	

func _on_base_smile_shaked(body) -> void:
	if body.tag == "FloppyDisk":
		is_shaking = true
		init_item_drop(body, droppables)


func _on_base_smile_intersected(bodies: Array) -> void:
	if merge_smiles(bodies, ["Airplane", "Gear"], spaceShipPacked, 1, 
					"res://Assets/Sounds/airplane+gear.mp3"):
		pass
		
	if merge_smiles(bodies, ["SpaceShip", "Alien"], flyiingSaurcerPacked, 1,
					"res://Assets/Sounds/alien+spaceshuttle.mp3"):
		pass
	
	if spawn_item(bodies, "FlyingSaucer", false,
						  "AlienMonster", true, 
						   hundredPointsPacked,
						   "res://Assets/Sounds/flying saucer+alien monster.mp3"):
		pass
		
	if merge_smiles(bodies, ["PokerFace", "HundredPoints"], happyFacePacked, 1,
					"res://Assets/Sounds/hundred points+char.mp3"):
		pass
	
	if merge_smiles(bodies, ["HappyFace", "HundredPoints"], smilyFacePacked, 1,
					"res://Assets/Sounds/hundred points+char.mp3"):
		pass
	
	if merge_smiles(bodies, ["SmilyFace", "HundredPoints"], roflFacePacked, 1,
				   "res://Assets/Sounds/hundred points+char.mp3"):
		level_completed.emit()
