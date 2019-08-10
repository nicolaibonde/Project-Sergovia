extends Node2D

const LOOP = preload("res://Player/ChainArm/Loop.tscn")
const LINK = preload("res://Player/ChainArm/Link.tscn")
const HAND = preload("res://Player/ChainArm/Hand.tscn")

export (int) var loops = 1

var hand
var last_child

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = $Anchor
	for i in range(loops):
		var child = addLoop(parent)
		addLink(parent, child)
		parent = child
		last_child = child
	hand = addHand(parent)

func addLoop(parent):
	var loop = LOOP.instance()
	loop.position = parent.position
	loop.position.x += 13
	add_child(loop)
	return loop
	
func addHand(parent):
	var loop = HAND.instance()
	loop.position = parent.position
	add_child(loop)
	return loop
	
func addLink(parent, child):
	var pin = LINK.instance()
	pin.node_a = parent.get_path()
	pin.node_b = child.get_path()
	parent.add_child(pin)

func _physics_process(delta):
	if hand != null:
		pass
	pass