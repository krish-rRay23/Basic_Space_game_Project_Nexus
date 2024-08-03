extends Control



	
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/player.tscn")

 
func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
