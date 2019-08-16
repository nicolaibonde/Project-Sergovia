extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var health = 3

onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	player.connect("damage",self,"_on_damage")


func _on_damage():
	health -= 1
	
	if health == 2:
		$Control/HBoxContainer/Heart3.visible = false
	elif health == 1:
		$Control/HBoxContainer/Heart2.visible = false
	else:
		$Control/HBoxContainer/Heart1.visible = false