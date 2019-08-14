extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (String) var boundry_group = "Patrol_A"
export (float) var movement_speed = 100
export (int) var health = 3
signal shake

# Called when the node enters the scene tree for the first time.
func _ready():
	var camera = get_tree().get_nodes_in_group("Main_Camera")
	self.connect("shake",camera[0],"shake")
	var boundaries = get_tree().get_nodes_in_group("Patrol_A")
	for boundary in boundaries:
		boundary.connect("",self,"")
	pass # Replace with function body.


var movement = Vector2()
var toggle = -1

func _physics_process(delta):
	movement = Vector2(toggle*movement_speed,0)
	position += movement * delta

func turn_around():
	if toggle == 1:
		toggle = -1
	else:
		toggle = 1

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
