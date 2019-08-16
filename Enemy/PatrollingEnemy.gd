extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (String) var boundry_group = "Patrol_A"
export (float) var movement_speed = 100
export (Vector2) var movement_dir = Vector2(1,0)
export (float) var spriteRotation = 0
export (int) var health = 3
export (String) var EnemyAnimation = "Enemy1"
signal shake

# Called when the node enters the scene tree for the first time.
func _ready():
	var camera = get_tree().get_nodes_in_group("Main_Camera")
	self.connect("shake",camera[0],"shake")
	movement_dir = movement_dir.normalized()
	$AnimatedSprite.play(EnemyAnimation)
	$AnimatedSprite.rotation = deg2rad(spriteRotation)


var movement = Vector2()
var toggle = -1



func _physics_process(delta):
	movement = movement_dir * toggle *movement_speed
	position += movement * delta

func turn_around():
	if toggle == 1:
		toggle = -1
		$AnimatedSprite.flip_h = false
	else:
		toggle = 1
		$AnimatedSprite.flip_h = true

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
