extends CharacterBody2D


const speed = 200
const dodgeSpeed = 2000.0
const dodgeDuration = 1
const dodgeCooldown = 0.1

@onready var sprite_2d = $Sprite2D


#different var to look at the players status 
var canDodge = true
var isDodging = false
var dodgeTimer = 0.0
var animation_state = "default"  # Default animation state

#Grab the inputs and return player movement 
func get_inputDirection():
	var input_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_direction.x += 1
	if Input.is_action_pressed("ui_up"):
		input_direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		input_direction.y += 1
	return input_direction.normalized()


#Handles moving and dodging
func _physics_process(_delta):


	if isDodging:
		dodgeTimer -= _delta
		if dodgeTimer <= 0.0:
			isDodging = false
			dodgeTimer = dodgeCooldown
			canDodge = true
			animation_state = "default"

	if Input.is_action_just_pressed("ui_accept") and canDodge:
		animation_state = "Dodge"
		velocity = get_inputDirection() * dodgeSpeed
		canDodge = false
		isDodging = true
		dodgeTimer = dodgeDuration

	else:
			velocity = get_inputDirection() * speed


	move_and_slide()


		
	#if Input.is_action_just_pressed("Attack"):
 
	#	pass
		


	

#flip the sprite to the left 
	var isleft = velocity.x < 0 
	sprite_2d.flip_h = isleft
	sprite_2d.animation = animation_state
	
