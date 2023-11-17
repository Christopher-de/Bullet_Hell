extends CharacterBody2D


const max_speed = 400.0
const accel = 1500
const friction = 600

@onready var sprite_2d = $Sprite2D

var input = Vector2.ZERO

func _physics_process(delta):
	player_movement(delta)
	#Animations 
	if (velocity.x > 1 || velocity.x < -1 || velocity.y < -1 || velocity.y > 1):
		sprite_2d.animation = "running"

#Grab the inputs and return player movement
func get_input():
		input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
		input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
		return input.normalized()

func player_movement(delta):
	input = get_input()


#This checks if the player is moving or not and controls accceration and max speed

	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)


	# Handle Jump.
	#if Input.is_action_just_pressed("ui_accept"):
#		velocity.y = JUMP_VELOCITY
		
		

	move_and_slide()

#flip the sprite to the left 
	var isleft = velocity.x < 0 
	sprite_2d.flip_h = isleft

	
