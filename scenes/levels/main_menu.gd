extends Node

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")

func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/options_menu.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
