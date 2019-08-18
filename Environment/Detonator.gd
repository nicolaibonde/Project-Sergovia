extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var level = 0

export (int) var health = 1
signal shake
signal detonation

# Called when the node enters the scene tree for the first time.
func _ready():
	var camera = get_tree().get_nodes_in_group("Main_Camera")
	var player = get_tree().get_nodes_in_group("Player")
	self.connect("shake",camera[0],"shake")
	self.connect("detonation",player[0],"_on_detonation")


func detonate():
	if level == 0:
		Globals.Tower1Completed = true
	elif level == 1:
		Globals.Tower2Completed = true
	elif level == 2:
		Globals.Tower3Completed = true
	elif level == 3:
		Globals.Tower4Completed = true
	
	$Sprite.texture = load("res://Assets/tiles/boom_on.png")
	
	emit_signal("shake",10,30,75)
	AudioManager.playSample("res://SoundEffects/Explosion1.wav",-10)
	var exit = get_tree().get_nodes_in_group("ExitPoint")[0]
	emit_signal("detonation",exit.global_position)

func damage(amount):
	if health <= 0:
		return health
	health -= amount
	detonate()
	return health
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
