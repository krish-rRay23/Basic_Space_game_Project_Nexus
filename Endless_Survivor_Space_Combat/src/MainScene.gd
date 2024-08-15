extends Node2D

func _ready():
	print(Global.testnum)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/1.tscn")
