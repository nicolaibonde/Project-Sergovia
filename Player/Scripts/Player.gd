extends KinematicBody2D

# Constants
const SPEED = 300
const GRAVITY = 9.82
#const TERMINAL_VELOCITY = 40000
const UP = Vector2(0,-1)

const JUMP_VELOCITY = 400
const LOW_JUMP_MULTIPLIER = 3
const FALL_MULTIPLIER = 3

var velocity = Vector2()

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	velocity.y += GRAVITY
	
	# Better platforming gravity 
	if ( velocity.y > 0 ):
		velocity.y += GRAVITY * (FALL_MULTIPLIER - 1)
	elif velocity.y < 0 and !Input.is_action_pressed("player_jump"):
		velocity.y += GRAVITY * (LOW_JUMP_MULTIPLIER - 1)
	

	velocity.x = 0
	if Input.is_action_pressed("player_left"):
		velocity.x -= Input.get_action_strength("player_left")
	if Input.is_action_pressed("player_right"):
		velocity.x += Input.get_action_strength("player_right")
	
	if is_on_ceiling():
		velocity.y = abs(velocity.y)/5
	
	if is_on_floor():
		velocity.y = 0

		
	if Input.is_action_just_pressed("player_jump"):
		if $FloorRay.is_colliding() or is_on_floor():
			velocity.y = -JUMP_VELOCITY
	

	velocity.x = velocity.x * SPEED
	move_and_slide(velocity, UP)