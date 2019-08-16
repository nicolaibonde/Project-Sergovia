extends Node2D

const LOOP = preload("res://Player/ChainArm/Loop.tscn")
const LINK = preload("res://Player/ChainArm/Link.tscn")
const HAND = preload("res://Player/ChainArm/Hand.tscn")
const EXTRA_CHAINS = 8

export (int) var loops = 1

var chainList = []
var chainHand

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = $Anchor
	for i in range(loops):
		var child = addLoop(parent)
		addLink(parent, child)
		parent = child
	var hand = addHand(parent)
	addLink(parent, hand, true)

func addLoop(parent):
	var loop = LOOP.instance()
	loop.position = parent.position
	var aim_vector = (get_global_mouse_position() - parent.global_position).normalized()
	loop.position += (aim_vector * 13)
	add_child(loop)
	chainList.append(loop)
	return loop

func addLink(parent, child, hide=false):
	var pin = LINK.instance()
#	pin.get_node("Sprite").visible = !hide
	pin.node_a = parent.get_path()
	pin.node_b = child.get_path()
	parent.add_child(pin)
	chainList.append(pin)
	
func addHand(parent):
	var hand = HAND.instance()
	hand.position = parent.position
	add_child(hand)
	var player = get_tree().get_nodes_in_group("Player")
	var camera = get_tree().get_nodes_in_group("Main_Camera")
	hand.connect("grabbed",player[0],"on_grab")
	hand.connect("ungrabbed",player[0],"on_release")
	hand.connect("retracted",self,"on_retracted")
	hand.connect("shake",camera[0],"shake")
	chainHand = hand
	return hand

# This remove both a loop and a link
func removeLoopItem():
	var item = chainList.pop_back()
	item.queue_free()

func removeHand():
	if chainHand != null:
		chainHand.disconnect("retracted",self,"on_retracted")
		chainHand.queue_free()
		chainHand = null
		removeLoopItem()

func on_retracted():
	extended = false
	removeHand()
	for i in range(EXTRA_CHAINS):
		removeLoopItem()
		removeLoopItem()
	var parent = chainList[chainList.size()-2]
	var hand = addHand(parent)
	addLink(parent, hand, true)

var extended = false

func _process(delta):
	if Input.is_action_just_pressed("player_fire") and extended:
		chainHand.refire()
	
	if Input.is_action_just_pressed("player_fire") and not extended:
		extended = true
		removeHand()
		var child = chainList[chainList.size()-1]
		var parent = chainList[chainList.size()-2]
		for i in range(EXTRA_CHAINS):
			child = addLoop(parent)
			addLink(parent, child)
			parent = child
		var hand = addHand(parent)
		addLink(parent, hand, true)
		chainHand.fire(16*2*(EXTRA_CHAINS))
