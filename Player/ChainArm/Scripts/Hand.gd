extends RigidBody2D

const DISTANCE = 80
const MIN_DISTANCE = DISTANCE -30
const FORCE = 1500
const RETRACTION_SPEED = 6

var pivot 
var player
var aim_vector = Vector2()
var grab_position
signal grabbed
signal ungrabbed
signal shake

# Called when the node enters the scene tree for the first time.
func _ready():	
	pivot = get_parent().get_node("Anchor")
	player = get_parent().get_parent()
	set_deferred("mode",MODE_KINEMATIC)
	
	pass # Replace with function body.

var detached = false
var fired = false
var extended_length = 0
var retracting = false
var retraction = 0
var retraction_start = Vector2()
signal retracted  
signal extended

var rotation_offset = 0

func fire(ext_len):
	extended_length = ext_len
	detached = true
	set_deferred("mode",MODE_RIGID)

func refire():
	fired = false
	detached = true
	retracting = false
	set_deferred("mode",MODE_RIGID)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	updateMovement(delta)
	
	if grab_position != null:
		$AnimatedSprite.flip_h = true
		rotation_offset = 350 
	elif player.looking_right:
		$AnimatedSprite.flip_h = true
		rotation_offset = 255
	elif not player.looking_right:
		$AnimatedSprite.flip_h = false
		rotation_offset = 350 -90
	
func updateMovement(delta):
	if player.health > 0:
		if grab_position != null:
			global_position = grab_position
			$AnimatedSprite.look_at(pivot.global_position)
			$AnimatedSprite.rotation = $AnimatedSprite.rotation + deg2rad(90 + rotation_offset)
	#		$AnimatedSprite.rotation = deg2rad(180)
			if Input.is_action_just_released("player_fire"):
				grab_position = null
				retracting = true
				retraction_start = global_position
				$AnimatedSprite.play("Open")
				emit_signal("ungrabbed")
	#			apply_impulse(Vector2(),-return_vector*FORCE*mass)
		else:
			aim_vector = (get_global_mouse_position() - pivot.global_position).normalized()
			$AnimatedSprite.look_at(get_global_mouse_position())
			$AnimatedSprite.rotation = $AnimatedSprite.rotation + deg2rad(rotation_offset)
			if not detached:
				if pivot.global_position.distance_to(get_global_mouse_position()) > DISTANCE:
					position = aim_vector * DISTANCE + pivot.position
				else:
					global_position = get_global_mouse_position()
					$AnimatedSprite.look_at(pivot.global_position)
					$AnimatedSprite.rotation = $AnimatedSprite.rotation + deg2rad(rotation_offset + 180)
			elif not fired and detached:
				$AnimatedSprite.play("Closed")
				apply_impulse(Vector2(),aim_vector*FORCE*mass)
				fired = true
			elif detached:
				if (pivot.global_position + player.velocity.normalized()*30).distance_to(global_position) >= extended_length:
					# retract
					retracting = true
					mode = MODE_KINEMATIC
					emit_signal("extended")
					retraction_start = global_position
					emit_signal("shake",0.07,40,2)
				if retracting:
					var goal = aim_vector * DISTANCE + pivot.global_position
					var temp = retraction_start.linear_interpolate(goal, retraction)
					global_position = temp
					retraction += delta * RETRACTION_SPEED
					if retraction >= 0.9:
						retraction = 0
						retracting = false
						detached = false
						fired = false
						emit_signal("retracted")
						$AnimatedSprite.play("Open")


func _on_Grabber_area_entered(area):
	if grab_position == null and area.is_in_group("grabbable"):
		if detached and Input.is_action_pressed("player_fire"):
			print("Grabbing: " + area.name)
			set_deferred("mode",MODE_KINEMATIC)
			grab_position = area.get_node("Pivot").global_position
			emit_signal("grabbed",grab_position,extended_length)


func _on_Grabber_body_entered(body):
	if fired and not retracting and body.is_in_group("Punchable"): 
		print("Punching: " + body.name)
		if body.has_method("damage"):
			AudioManager.playSample("res://SoundEffects/Punch.wav",-25)
			var hp = body.damage(1)
			if hp > 0:
				emit_signal("shake",0.1,40,8)
		retracting = true
		mode = MODE_KINEMATIC
		emit_signal("extended")
		retraction_start = global_position
