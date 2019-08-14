extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var health = 3
signal shake

# Called when the node enters the scene tree for the first time.
func _ready():
	var camera = get_tree().get_nodes_in_group("Main_Camera")
	self.connect("shake",camera[0],"shake")


func die():
	emit_signal("shake",0.3,80,30)
	queue_free()
	pass

func damage(amount):
	health -= amount
	if health <= 0:
		die()
	return health
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
