extends Control

func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")


func _on_credits_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()


func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://scenes/player.tscn")

