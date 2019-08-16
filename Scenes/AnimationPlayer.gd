extends AnimationPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(NodePath) var main_menu_path
onready var main_menu = get_node(main_menu_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	play("fade_in_out")
	yield(self,"animation_finished")
	SceneChanger.change_scene("res://Scenes/MainMenu.tscn",0)
	pass # Replace with function body.


func _process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
