extends Node2D

@onready var left_unicorn = $LeftUnicorn
@onready var right_unicorn = $RightUnicorn


func play():
	left_unicorn.play("unicorn_show")
	right_unicorn.play("unicorn_show")


func _on_left_unicorn_animation_finished():
	left_unicorn.play("unicorn_loop")


func _on_right_unicorn_animation_finished():
	right_unicorn.play("unicorn_loop")
