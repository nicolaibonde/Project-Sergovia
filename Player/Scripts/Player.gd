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

var chain_anchor = Vector2()

var looking_right = true

var health = 3

var exit_location = Vector2()
var detonated = false
var detonation_speed = 2500

func _ready():
	chain_anchor = $Chain.position

func _physics_process(delta):
	if detonated :
		var vector = (exit_location - global_position).normalized()
		if detonation_speed > 500:
			detonation_speed -= 2500 *delta
		global_position += vector * detonation_speed * delta
	else:
		
		if health > 0:
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
				velocity.x -= ACCELERATION
				anim_left()
				looking_right = false
				
			if Input.is_action_pressed("player_right"):
				velocity.x += ACCELERATION
				anim_right()
				looking_right = true
		
			if not Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right") and is_on_floor():
				anim_stop()
				velocity.x =  lerp(velocity.x,0,1)
				
			velocity.x = clamp(velocity.x,-top_move_speed,top_move_speed)
		
			if is_on_ceiling():
				velocity.y = abs(velocity.y)/5
		
			if is_on_floor():
				jumping = false
				velocity.y = 0
			
			if not on_floor:
				jumping = true
				anim_jump()		
		
		
			if Input.is_action_just_pressed("player_jump"):
				if on_floor or is_on_floor():
					velocity.y = -JUMP_VELOCITY
					anim_jump()
					jumping = true
			
			if grab_position != null:
				velocity = velocity *0.98
				
			move_and_slide(velocity, UP)
		
		else:
			if $AnimationPlayer.is_playing():
				var movement = Vector2(0,1) * -60
				position += movement * delta
		

func _on_detonation(exit):
	detonated = true
	exit_location = exit
#	set_collision_layer_bit(0,0)
#	set_collision_layer_bit(1,0)


func on_grab(grab_pos, max_dist):
	grab_position = grab_pos
	max_chain_length = max_dist*0.70
	
func on_release():
	grab_position = null


signal damage
signal death

func damage(amount):
	if health > 0:
		if $AnimationPlayer.is_playing():
			pass
		else:
			emit_signal("damage")
			health -= amount
			if health <= 0:
				die()
			else:
				$AnimationPlayer.play("Damage")

func die():
	$AnimationPlayer.play("Die")
	emit_signal("death")
	
################### Animations


var jumping = false

func anim_stop():
	$AnimatedSprite.play("Idle")
	
func anim_left():
	if not jumping:
		$AnimatedSprite.play("Walk")
	$Chain.position.x = -chain_anchor.x
	$AnimatedSprite.flip_h = true

func anim_right():
	if not jumping:
		$AnimatedSprite.play("Walk")
	$Chain.position.x = chain_anchor.x
	$AnimatedSprite.flip_h = false
	pass

func anim_jump():
	$AnimatedSprite.play("Jump")
	pass
	
var on_floor = true

func _on_FloorBox_body_entered(body):
	on_floor = true


func _on_FloorBox_body_exited(body):
	on_floor = false