extends CharacterBody2D


const max_speed = 250.0
const accel = 2000
const friction = 700
const dodge_velocity = 200

@onready var sprite_2d = $Sprite2D

var input = Vector2.ZERO
var dodge_roll = dodge_velocity

func _physics_process(delta):
	player_movement(delta)
	#Animations 
	if (input != Vector2.ZERO):
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"

	
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


	
		
		
		

	move_and_slide()

#flip the sprite to the left 
	var isleft = velocity.x < 0 
	sprite_2d.flip_h = isleft

	
