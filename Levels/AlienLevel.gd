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
	droppables = [alientPacked, alienMonsterPacked, airplanePacked]
	

func _on_base_smile_shaked(body) -> void:
	if body.tag == "FloppyDisk":
		is_shaking = true
		init_item_drop(body, droppables)


func _on_base_smile_intersected(bodies: Array) -> void:
	if merge_smiles(bodies, ["Airplane", "Gear"], spaceShipPacked):
		pass
		
	if merge_smiles(bodies, ["SpaceShip", "Alien"], flyiingSaurcerPacked):
		pass
	
	if merge_smiles(bodies, ["FlyingSaucer", "AlienMonster"], hundredPointsPacked):
		pass
		
	if merge_smiles(bodies, ["PokerFace", "HundredPoints"], roflFacePacked):
		level_completed.emit()
