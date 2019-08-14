extends KinematicBody2D

# Constants
const ACCELERATION = 100
const GRAVITY = 9.82
const UP = Vector2(0,-1)

const JUMP_VELOCITY = 400
const LOW_JUMP_MULTIPLIER = 3
const FALL_MULTIPLIER = 3

const top_move_speed = 300

var velocity = Vector2()

var grab_position = null
var max_chain_length = 0

func _physics_process(delta):

	velocity.y += GRAVITY
	if grab_position != null:
		var pivot = $Chain.global_position
		var current_chain = pivot - grab_position
		var error = current_chain - current_chain.normalized()*max_chain_length
		if current_chain.length() - max_chain_length > 0:
			velocity -= error
			#TODO dont do opposite velocity, just move the player to the positoo
	else:
		pass
	
	
	# Better platforming gravity 
	if ( velocity.y > 0 ):
		velocity.y += GRAVITY * (FALL_MULTIPLIER - 1)
	
	if velocity.y < 0 and !Input.is_action_pressed("player_jump"):
		velocity.y += GRAVITY * (LOW_JUMP_MULTIPLIER - 1)
	
	#TODO: Fix deacceleration with controller, now results in jitter
	if Input.is_action_pressed("player_left"):
		velocity.x -= Input.get_action_strength("player_left")*ACCELERATION
	if Input.is_action_pressed("player_right"):
		velocity.x += Input.get_action_strength("player_right")*ACCELERATION

	if not Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right") and is_on_floor():
		if velocity.x > 5:
			velocity.x -= ACCELERATION
		elif velocity.x < -5:
			velocity.x += ACCELERATION
		else:
			velocity.x = 0
	velocity.x = clamp(velocity.x,-top_move_speed,top_move_speed)

	if is_on_ceiling():
		velocity.y = abs(velocity.y)/5

	if is_on_floor():
		velocity.y = 0


	if Input.is_action_just_pressed("player_jump"):
		if $FloorRay.is_colliding() or is_on_floor():
			velocity.y = -JUMP_VELOCITY
	
	move_and_slide(velocity, UP)
	
	if grab_position != null:
		velocity = velocity *0.98
			
	
func on_grab(grab_pos, max_dist):
	grab_position = grab_pos
	max_chain_length = max_dist*0.75
	
func on_release():
	grab_position = null