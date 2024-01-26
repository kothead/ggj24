extends Node2D


var gameScreen = preload("res://Screens/GameScreen.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(gameScreen)
