extends Level


var roflFacePacked = load("res://Objects/ROFLFace.tscn")

var lizardPacked = load("res://Objects/Lizard.tscn")
var boarPacked = load("res://Objects/Boar.tscn")
var poodlePacked = load("res://Objects/Poodle.tscn")
var catPacked = load("res://Objects/Cat.tscn")

func _ready() -> void:
	super._ready()
	droppables = [lizardPacked, boarPacked, poodlePacked, catPacked]
	

func _on_base_smile_shaked(body) -> void:
	if body.tag == "MagicWand":
		is_shaking = true
		init_item_drop(body, droppables)
		
		
func _on_base_smile_intersected(bodies: Array) -> void:
	if merge_smiles(bodies, ["PokerFace", "Cat"], roflFacePacked):
		level_completed.emit()
