extends CharacterBody2D
#This is the original repo folder
@onready var main = get_tree().get_root().get_node("main")
@onready var enemy = load("res://mob.tscn")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
func _ready():
	print("READY RUNNING")
	animated_sprite_2d.play("default")
	print("WORKS")
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

func spawnEnemy():
	var instance = enemy.instantiate()
	var spawnLoc = randi_range(1, 4)
	var xOffset
	var yOffset
	if(spawnLoc == 1):
		xOffset = randi_range(-1250, -1000)
		yOffset = randi_range(-500, 500)
	elif(spawnLoc == 2):
		xOffset = randi_range(1000, 1250)
		yOffset = randi_range(-500, 500)
	elif(spawnLoc == 3):
		xOffset = randi_range(-900, 900)
		yOffset = randi_range(600, 750)
	else:
		xOffset = randi_range(-900, 900)
		yOffset = randi_range(-750, -600)
	instance.spawnPos = Vector2(global_position.x - xOffset, global_position.y - yOffset)
	main.add_child.call_deferred(instance)

func _on_spawn_timer_timeout() -> void:
	spawnEnemy()
	pass # Replace with function body.
