extends Control


func _ready():
	visible = false

func _input(event):
	if event.is_action_pressed("pause"):
		pause()
		

func pause():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state


func _on_Resume_pressed():
	pause()	


func _on_Restart_pressed():
	pause()
	get_tree().reload_current_scene()


func _on_Level_Select_pressed():
	pause()
	SceneChanger.change_scene("res://Scenes/LevelSelect.tscn")


func _on_Main_Menu_pressed():
	pause()
	SceneChanger.change_scene("res://Scenes/MainMenu.tscn")


