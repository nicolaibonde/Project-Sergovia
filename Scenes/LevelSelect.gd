extends Control

func _on_Tower1_pressed():
	SceneChanger.change_scene("res://Scenes/Tower1.tscn")

func _on_Tower2_pressed():
	SceneChanger.change_scene("res://Scenes/Tower2.tscn")

func _on_Tower3_pressed():
	SceneChanger.change_scene("res://Scenes/Tower3.tscn")

func _on_Tower4_pressed():
	SceneChanger.change_scene("res://Scenes/Tower4.tscn")

func _on_Back_pressed():
	print("hi")
	SceneChanger.change_scene("res://Scenes/MainMenu.tscn")
	pass # Replace with function body.
