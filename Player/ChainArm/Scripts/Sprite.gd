extends Sprite

onready var nodeA = getNode("node_a")
onready var nodeB = getNode("node_b")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getNode(name):
	return get_parent().get_node(get_parent()[name])

func _physics_process(delta):
	global_rotation = nodeB.position.angle_to_point(nodeA.position)