extends Control

onready var player = get_tree().get_nodes_in_group("Player")[0]

var dead = false

func _ready():
	mouse_filter = Control.MOUSE_FILTER_PASS
	player.connect("death",self,"_on_die")
	visible = false


func _on_die():
	dead = true

func _input(event):
	if event.is_action_pressed("pause"):
		pause()
		

func pause():
	if not dead:
		mouse_filter = Control.MOUSE_FILTER_STOP
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


