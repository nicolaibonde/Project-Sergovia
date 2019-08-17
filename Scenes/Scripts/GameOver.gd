extends Control

onready var player = get_tree().get_nodes_in_group("Player")[0]


func _ready():
	mouse_filter = Control.MOUSE_FILTER_PASS
	player.connect("death",self,"_on_die")
	visible = false


func _on_die():
	mouse_filter = Control.MOUSE_FILTER_STOP
	visible = true

func _on_Restart_pressed():
	AudioManager.playSample("res://SoundEffects/Select.wav",-30)
	get_tree().reload_current_scene()


func _on_Level_Select_pressed():
	AudioManager.playSample("res://SoundEffects/Select.wav",-30)
	SceneChanger.change_scene("res://Scenes/LevelSelect.tscn")


func _on_Main_Menu_pressed():
	AudioManager.playSample("res://SoundEffects/Select.wav",-30)
	SceneChanger.change_scene("res://Scenes/MainMenu.tscn")


