extends Level


var roflFacePacked = load("res://Objects/ROFLFace.tscn")

var detectivePacked = load("res://Objects/Detective.tscn")
var moneyPacked = load("res://Objects/Money.tscn")
var picturePacked = load("res://Objects/Picture.tscn")


func _on_base_smile_intersected(bodies: Array) -> void:
	if merge_smiles(bodies, ["FlyingSaucer", "Cow"], detectivePacked, 1,
					"res://Assets/Sounds/ufo+cow.mp3"):
		pass
		
	if spawn_item(bodies, "FlyingSaucer", false, "Camera", true, picturePacked,
				  "res://Assets/Sounds/camera+all.mp3"):
		pass
		
	if merge_smiles(bodies, ["Detective", "Picture"], moneyPacked, 1,
					"res://Assets/Sounds/picture+detective.mp3"):
		pass
	
	if merge_smiles(bodies, ["PokerFace", "Money"], moneyPacked, 1,
					"res://Assets/Sounds/char+money.mp3"):
		level_completed.emit()
