extends Level


var roflFacePacked = load("res://Objects/ROFLFace.tscn")

var packed = [
	load("res://Objects/Airplane.tscn"),
	load("res://Objects/Alien.tscn"),
	load("res://Objects/AlienMonster.tscn"),
	load("res://Objects/Boar.tscn"),
	load("res://Objects/Brain.tscn"),
	load("res://Objects/Camera.tscn"),
	load("res://Objects/Candy.tscn"),
	load("res://Objects/Cat.tscn"),
	load("res://Objects/Cheese.tscn"),
	load("res://Objects/Cityscape.tscn"),
	load("res://Objects/Coffin.tscn"),
	load("res://Objects/Computer.tscn"),
	load("res://Objects/Cow.tscn"),
	load("res://Objects/Dagger.tscn"),
	load("res://Objects/Detective.tscn"),
	load("res://Objects/Flatbread.tscn"),
	load("res://Objects/FloppyDisk.tscn"),
	load("res://Objects/FlyingSaucer.tscn"),
	load("res://Objects/Gear.tscn"),
	load("res://Objects/Headstone.tscn"),
	load("res://Objects/Heart.tscn"),
	load("res://Objects/HundredPoints.tscn"),
	load("res://Objects/Instagram.tscn"),
	load("res://Objects/Joystick.tscn"),
	load("res://Objects/Like.tscn"),
	load("res://Objects/Lizard.tscn"),
	load("res://Objects/Lollipop.tscn"),
	load("res://Objects/MagicWand.tscn"),
	load("res://Objects/MagnifyingGlass.tscn"),
	load("res://Objects/Money.tscn"),
	load("res://Objects/Package.tscn"),
	load("res://Objects/Picture.tscn"),
	load("res://Objects/Pinata.tscn"),
	load("res://Objects/Pizza.tscn"),
	load("res://Objects/Poodle.tscn"),
	load("res://Objects/Robot.tscn"),
	load("res://Objects/RobotHuman.tscn"),
	load("res://Objects/Scissors.tscn"),
	load("res://Objects/Shovel.tscn"),
	load("res://Objects/SpaceShip.tscn"),
	load("res://Objects/WasteBasket.tscn"),
	load("res://Objects/ZombieMan.tscn"),
	load("res://Objects/ZombieWoman.tscn")
]


func _ready() -> void:
	super._ready()
	packed.shuffle()
	droppables = packed
	droppables.append(load("res://Objects/GGJ.tscn"))
	

func _on_base_smile_shaked(body) -> void:
	if body.tag == "Computer":
		is_shaking = true
		init_item_drop(body, droppables)
		
		
func _on_base_smile_intersected(bodies: Array) -> void:
	if merge_smiles(bodies, ["PokerFace", "GGJ"], roflFacePacked):
		level_completed.emit()
