extends CharacterBody2D


const SPEED = 300.0

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction.normalized() * SPEED

func _physics_process(delta: float) -> void:

#	var directionX = 0.0
#	var directionY = 0.0
#	if(Input.is_key_pressed(KEY_A)):
#		directionX -= 1
#	if(Input.is_key_pressed(KEY_D)):
#		directionX += 1
#		
#	if(Input.is_key_pressed(KEY_W) and !Input.is_key_pressed(KEY_S)):
#		directionY -= 1
#	if(Input.is_key_pressed(KEY_S) and !Input.is_key_pressed(KEY_W)):
#		directionY += 1
#	
#	velocity.x = (directionX * SPEED)
#	velocity.y = (directionY * SPEED)
#	if(directionX != 0 and directionY != 0):
#		velocity.x = (directionX * SPEED)/sqrt(2)
#		velocity.y = (directionY * SPEED)/sqrt(2)
#	if(directionY == 0):
#		velocity.x = (directionX * SPEED)
#		velocity.y = 1
#		
	get_input()
	move_and_slide()
