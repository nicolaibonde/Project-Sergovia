extends RigidBody2D

const DISTANCE = 46

var pivot 
var spawned_hand
var aim_vector = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	pivot = get_parent().get_node("Anchor")
	set_deferred("mode",MODE_KINEMATIC)
	pass # Replace with function body.

func hand_connect(hand, collider):
	print(collider.name)
	var _h = hand
	
	get_parent().remove_child(_h)
	collider.add_child(_h)
	spawned_hand = _h

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	aim_vector = (get_global_mouse_position() - pivot.global_position).normalized()
	position = aim_vector * DISTANCE + pivot.position
	$Sprite.look_at(get_global_mouse_position())
	
#	if Input.is_action_just_pressed("player_fire"):
#		if spawned_hand == null:
#			spawned_hand = hand.instance()
#			spawned_hand.start(position,0, aim_vector)
#			spawned_hand.arm = self
#			get_parent().add_child(spawned_hand)
#		else:
#			spawned_hand.queue_free()
#			spawned_hand = null