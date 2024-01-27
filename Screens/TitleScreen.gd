extends Node2D

var gameScreen = preload("res://Screens/GameScreen.tscn")


func _process(delta):
	if Input.is_action_just_pressed("Start"):
		get_tree().change_scene_to_packed(gameScreen)
