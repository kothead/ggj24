extends Level

var boarPacked = load("res://Objects/Boar.tscn")
var picturePacked = load("res://Objects/Picture.tscn")
var likePacked = load("res://Objects/Like.tscn")

var smilyFacePacked = load("res://Objects/SmilyFace.tscn")
var roflFacePacked = load("res://Objects/ROFLFace.tscn")

var cityPicture = false
var boarPicture = false

func _on_base_smile_intersected(bodies: Array) -> void:
	spawn_boar(bodies, "Cityscape", false, "WasteBasket", true, boarPacked)
		
	if not cityPicture:
		cityPicture = spawn_item(bodies, "Camera", false, "Cityscape", false, picturePacked)
	if not boarPicture:
		boarPicture = spawn_item(bodies, "Camera", false, "Boar", false, picturePacked)
	
	spawn_item(bodies, "Picture", true, "Instagram", false, likePacked)
	
	merge_smiles(bodies, ["PokerFace", "Like"], smilyFacePacked)
	
	if merge_smiles(bodies, ["SmilyFace", "Like"], roflFacePacked):
		level_completed.emit()
		
