extends Control

const selectVolume = -30


#TODO replace texture instead!
func _ready():
	if Globals.Tower1Completed:
		$CenterContainer/TextureRect/Tower1.texture_normal = load("res://Assets/map/tower-complete.png")
	if Globals.Tower2Completed:
		$CenterContainer/TextureRect/Tower2.texture_normal = load("res://Assets/map/tower-complete.png")
	if Globals.Tower3Completed:
		$CenterContainer/TextureRect/Tower3.texture_normal = load("res://Assets/map/tower-complete.png")
	if Globals.Tower4Completed:
		$CenterContainer/TextureRect/Tower4.texture_normal = load("res://Assets/map/tower-complete.png")


func _on_Tower1_pressed():
	AudioManager.playSample("res://SoundEffects/Select.wav",selectVolume)
	AudioManager.playLevelTheme()
	SceneChanger.change_scene("res://Scenes/Tower1.tscn")

func _on_Tower2_pressed():
	AudioManager.playSample("res://SoundEffects/Select.wav",selectVolume)
	AudioManager.playLevelTheme()
	SceneChanger.change_scene("res://Scenes/Tower2.tscn")

func _on_Tower3_pressed():
	AudioManager.playSample("res://SoundEffects/Select.wav",selectVolume)
	AudioManager.playLevelTheme()
	SceneChanger.change_scene("res://Scenes/Tower3.tscn")

func _on_Tower4_pressed():
	AudioManager.playSample("res://SoundEffects/Select.wav",selectVolume)
	AudioManager.playLevelTheme()
	SceneChanger.change_scene("res://Scenes/Tower4.tscn")

func _on_Back_pressed():
	AudioManager.playSample("res://SoundEffects/Select.wav",selectVolume)
	SceneChanger.change_scene("res://Scenes/MainMenu.tscn")

## Mega hack, lol

func _on_Tower1_mouse_entered():
	$CenterContainer/TextureRect/Tower1.modulate = Color.gray

func _on_Tower1_mouse_exited():
	$CenterContainer/TextureRect/Tower1.modulate = Color.white

func _on_Tower2_mouse_entered():
	$CenterContainer/TextureRect/Tower2.modulate = Color.gray

func _on_Tower2_mouse_exited():
	$CenterContainer/TextureRect/Tower2.modulate = Color.white

func _on_Tower3_mouse_entered():
	$CenterContainer/TextureRect/Tower3.modulate = Color.gray

func _on_Tower3_mouse_exited():
	$CenterContainer/TextureRect/Tower3.modulate = Color.white

func _on_Tower4_mouse_entered():
	$CenterContainer/TextureRect/Tower4.modulate = Color.gray

func _on_Tower4_mouse_exited():
	$CenterContainer/TextureRect/Tower4.modulate = Color.white
