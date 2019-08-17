extends Control

func _on_PlayButton_pressed():
	AudioManager.playSample("res://SoundEffects/Select.wav",-30)
	SceneChanger.change_scene("res://Scenes/LevelSelect.tscn",0)
