extends CanvasLayer

signal scene_changed()

onready var anim_player = $AnimationPlayer
onready var black = $Control/ColorRect


func change_scene(path, delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	anim_player.play("fade_out")
	yield(anim_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	anim_player.play_backwards("fade_out")
	emit_signal("scene_changed")